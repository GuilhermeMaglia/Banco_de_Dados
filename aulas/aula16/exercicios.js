// 01 - Liste todas as selecoes cadastradas.

db.selecoes.find({}, { pais: 1, _id: 0 })

// 02 - Liste apenas pais e grupo.

db.selecoes.find({}, { pais: 1, grupo: 1, _id: 0 })

// 03 - Liste as selecoes do grupo B.

db.selecoes.find({"grupo": "B"}, {pais: 1, _id: 0} )

// 04 - Liste as selecoes com ranking FIFA menor que 10.

db.selecoes.find({ ranking_fifa: { $lt: 10 } }, { pais: 1, ranking_fifa: 1, _id: 0 })

// 05 - Mostre apenas os jogadores da selecao Brasil.

db.selecoes.find({ "pais": "Brasil" }, {jogadores: 1, _id: 0 })

// 06 - Liste as selecoes que possuem jogadores com mais de 30 anos.

 db.selecoes.find({ "jogadores.idade": {$gt: 30} }, {pais: 1, jogadores: 1, _id: 0 })

// Listagem sem o nome da seleção

 db.selecoes.find({ "jogadores.idade": {$gt: 30} }, {jogadores: 1, _id: 0 })


// 07 - Mostre apenas os nomes dos jogadores da Argentina.

db.selecoes.aggregate([ 
    { $match: { pais: "Argentina" } }, 
    { $project: { nome: "$jogadores.nome", _id: 0 } }
])

// 08 - Liste todas as partidas.

 db.partidas.find()

// 09 - Mostre as partidas em que o Brasil participou.

db.partidas.find({
    $or: [
        {selecao_casa: "Brasil"},
        {selecao_fora: "Brasil"}
    ]
 })

// 10 - Liste as partidas com mais de 3 gols.

db.partidas.find({ $expr: { $gt: [ { $add: ["$gols_casa", "$gols_visitante"] }, 3] } })

// 11 - Mostre os eventos da partida Brasil x Uruguai.

db.partidas.find({ 
    $or: [ 
        { selecao_casa: "Brasil", selecao_visitante: "Uruguai" }, 
        { selecao_cas: "Uruguai", selecao_visitante: "Brasil" } 
    ]
})

// Listagem sem os eventos e id

db.partidas.find({ 
    $or: [ 
        { selecao_casa: "Brasil", selecao_visitante: "Uruguai" }, 
        { selecao_cas: "Uruguai", selecao_visitante: "Brasil" } 
    ]
}, {eventos: 0, _id: 0})

// 12 - Liste partidas que possuem eventos do tipo Gol.

db.partidas.find({"eventos.tipo": "Gol"})

// 13 - Mostre os jogadores que marcaram gols.

db.partidas.aggregate([
    { $unwind: "$eventos" },
    { $match: { "eventos.tipo": "Gol" } },
    { $group: { _id: "$eventos.jogador" } },
    { $project: { jogador: "$_id", _id: 0 } }
])