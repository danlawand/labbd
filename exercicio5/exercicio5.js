db.equipamentos.find(
  { "preco": {$gte: 200},
    "preco": {$lte: 300}

  },
  {"modelo":1, "tipo":1, "preco":1, "_id":0}
);

db.equipamentos.find(
  { $or: [{"tipo": "impressora"}, {"tipo":"pc"}]
  },
  {"fabricante":1, "_id":0}
)

db.equipamentos.find({ "tipo":"pc",$or:[{"cd":"6x"},{"cd":"8x"}],"preco":{$lt: 2000}}, {"modelo":1, "velocidade":1, "hd":1, "_id":0}).sort({"velocidade":-1}, {"hd":-1})

db.fabricantes.find({$or:[{"fabricante":{$regex:'^[abcdeABCDE]'}}]},{"equipamentos.modelo":1, "_id":0}).sort({"fabricante":1})


db.equipamentos.find({"tipo":"impressora", "tipo_impressao":{$not:{$regex: 'ink-jet'}}},{"fabricante":1, "modelo":1,"_id":0})

db.equipamentos.find({}, {"fabricante":1, "modelo":1, "preco":1, "_id":0})

Encontre os fabricantes que vendem tanto impressoras quanto PCs (ou seja, se um fabricante
vende PCs mas não vende impressoras, então não deve aparecer na resposta).

db.fabricantes.find({$and: [{"equipamentos.tipo":"pc"}, {"equipamentos.tipo":"impressora"}]}, {"fabricante":1,"_id":0})


############# ERRADO

h) Liste os fabricantes que vendem computadores (PCs ou Laptops) por mais de R$2.000,00 mas
que não vendem impressoras por mais de R$300,00.

Listar Fabricantes : {"fabricante":1,"_id":0}
and [(PCs ou Laptops  preco > 2000), (not impressora preco > 300)]

db.fabricantes.find({$and:[{$or: [{"equipamneto.tipo":"pc"}, {"equipamento.tipo":"laptop"}]}, {"preco":{$gt:2000}}]})


db.fabricantes.find(
  {
   $and: [ {$and:[#NOT{"equipamentos.tipo":"impressora"}, "equipamentos.preco":300]#,
    $or: [{"equipamentos": {"tipo":"pc", "preco":{$gt:2000}}},{"equipamentos": {"tipo":"laptop", "preco":{$gt:2000}}}]

   ]},
)

db.fabricantes.find({$and: ["equipamentos": {"tipo":"impressora", "preco":{$gt300}},$or: [{"equipamentos": {"tipo":"pc", "preco":{$gt:2000}}}, {"equipamentos":{"tipo":"laptop", "preco":{$gt:2000}}}]]}, {"fabricante":1, "_id":0})

db.fabricantes.find({$and: ["equipamentos": {"tipo":"impressora", "preco":{$gt300}},$or: [{"equipamentos": {"tipo":"pc", "preco":{$gt:2000}}}, {"equipamentos":{"tipo":"laptop", "preco":{$gt:2000}}}]]}, {"fabricante":1, "_id":0})


db.fabricantes.


db.fabricantes.find({$and: [{$not:["equipamentos": {"tipo":"impressora", "preco":{$gt300}}]},$or: [{"equipamentos": {"tipo":"pc", "preco":{$gt:2000}}}, {"equipamentos":{"tipo":"laptop", "preco":{$gt:2000}}}]]}, {"fabricante":1, "_id":0})

####################



db.inventory.find( { qty: { $exists: true, $nin: [ 5, 15 ] } } )

db.fabricantes.find(
  {
    "equipamentos": {$elemMatch: {"tipo":"impressora", "preco": $nin[{$gt:300}]}},
    $or: 
    [
      {"equipamentos": {"tipo":"pc", "preco":{$gt:2000}}},
      {"equipamentos":{"tipo":"laptop", "preco":{$gt:2000}}}
    ]
  },
  {"fabricante":1, "_id":0}
)

db.fabricantes.find({"equipamentos": {"tipo":"pc", "preco":{$gt:2000}}},{"fabricante":1, "_id":0})

db.fabricantes.find({"tipo":"pc", "preco":{$gt:2000}},{"fabricante":1, "_id":0})


db.fabricantes.find({$or: [{"equipamentos": {"tipo":"pc", "preco":{$gt:2000}}},{"equipamentos":{"tipo":"laptop", "preco":{$gt:2000}}}]},{"fabricante":1, "_id":0})



db.fabricantes.find({"equipamentos": {$elemMatch: {"tipo":"impressora", "preco": {$lte:300}}},$or: [{"equipamentos": {"tipo":"pc", "preco":{$gt:2000}}},{"equipamentos":{"tipo":"laptop", "preco":{$gt:2000}}}]},{"fabricante":1, "_id":0})




