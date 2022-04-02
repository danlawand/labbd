CREATE TABLE usuario (
	id SERIAL NOT NULL,
	nome VARCHAR(100),
	email VARCHAR(150),
	PRIMARY KEY(id)
);

CREATE TABLE equipe (
	id SERIAL NOT NULL,
	nome VARCHAR(100),
	PRIMARY KEY(id)
);

CREATE TABLE equipe_usuario (
	id SERIAL NOT NULL,
	equipe_id INTEGER NOT NULL,
	usuario_id INTEGER NOT NULL,
	FOREIGN KEY(equipe_id) REFERENCES equipe (id),
	FOREIGN KEY(usuario_id) REFERENCES usuario (id),
	PRIMARY KEY(id)
);


INSERT INTO equipe (id, nome)
VALUES (1, 'equipe1'), (2, 'equipe2');

INSERT INTO usuario (id, nome, email)
VALUES (1, 'usuario1', 'usuario1@mail.com'), (2, 'usuario2', 'usuario2@mail.com');

INSERT INTO equipe_usuario (id, equipe_id, usuario_id)
VALUES (1, 1, 1), (2, 1, 2), (3, 2, 2);

------------------------------------------------------------------------

SELECT row_to_json(usuario) FROM usuario;

------------------------------------------------------------------------

SELECT row_to_json(row(id, nome)) FROM usuario;

-- opcao melhor
SELECT row_to_json(usuarios) FROM (SELECT id, nome FROM usuario) AS usuarios;

------------------------------------------------------------------------

SELECT array_to_json(array_agg(row_to_json(usuarios)))
FROM (
  SELECT id, nome from usuario
) usuarios;

-- ou

SELECT json_agg(row_to_json(usuarios))
FROM (
  SELECT id, nome from usuario
) usuarios;


------------------------------------------------------------------------

SELECT json_build_object(
	'usuarios', (SELECT json_agg(row_to_json(usuario)) from usuario),
	'equipes', (SELECT json_agg(row_to_json(equipe)) from equipe)
);

------------------------------------------------------------------------

SELECT row_to_json(t)
FROM (
  SELECT e.id, e.nome, 
  	(
	SELECT json_agg(row_to_json(usuario))
	FROM usuario where id = eu.usuario_id 
	) as usuarios
  FROM equipe e, equipe_usuario eu
  WHERE e.id = eu.equipe_id) t;


------------------------------------------------------------------------

select json_agg(row_to_json(eu))
from (
  select id, (
      select row_to_json(equipe) from equipe where equipe_usuario.equipe_id = equipe.id
  ) equipe, (
      select row_to_json(usuario) from usuario where equipe_usuario.usuario_id = usuario.id
  ) usuario
from equipe_usuario
) eu;


