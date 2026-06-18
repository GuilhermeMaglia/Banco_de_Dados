/******************************************************************
 COPA DO MUNDO 2026
 MONGODB
******************************************************************/


// use copa_do_mundo;

db.selecoes.drop();
db.partidas.drop();

db.selecoes.insertMany([
{
    pais: "Argentina",
    grupo: "A",
    ranking_fifa: 1,
    jogadores: [
        { numero: 10, nome: "Messi", posicao: "Atacante", idade: 39 },
        { numero: 9, nome: "Julian Alvarez", posicao: "Atacante", idade: 27 },
        { numero: 8, nome: "Enzo Fernandez", posicao: "Meia", idade: 25 },
        { numero: 19, nome: "Otamendi", posicao: "Zagueiro", idade: 38 },
        { numero: 23, nome: "Martinez", posicao: "Goleiro", idade: 34 }
    ]
},
{
    pais: "Franca",
    grupo: "A",
    ranking_fifa: 2,
    jogadores: [
        { numero: 10, nome: "Mbappe", posicao: "Atacante", idade: 28 },
        { numero: 7, nome: "Griezmann", posicao: "Meia", idade: 35 },
        { numero: 8, nome: "Camavinga", posicao: "Meia", idade: 24 },
        { numero: 4, nome: "Saliba", posicao: "Zagueiro", idade: 27 },
        { numero: 1, nome: "Maignan", posicao: "Goleiro", idade: 31 }
    ]
},
{
    pais: "Brasil",
    grupo: "B",
    ranking_fifa: 3,
    jogadores: [
        { numero: 10, nome: "Neymar", posicao: "Atacante", idade: 34 },
        { numero: 7, nome: "Vini Jr", posicao: "Atacante", idade: 26 },
        { numero: 11, nome: "Rodrygo", posicao: "Atacante", idade: 25 },
        { numero: 4, nome: "Marquinhos", posicao: "Zagueiro", idade: 32 },
        { numero: 1, nome: "Alisson", posicao: "Goleiro", idade: 33 }
    ]
},
{
    pais: "Inglaterra",
    grupo: "B",
    ranking_fifa: 4,
    jogadores: [
        { numero: 9, nome: "Harry Kane", posicao: "Atacante", idade: 33 },
        { numero: 10, nome: "Bellingham", posicao: "Meia", idade: 24 },
        { numero: 7, nome: "Saka", posicao: "Atacante", idade: 25 },
        { numero: 5, nome: "Stones", posicao: "Zagueiro", idade: 32 },
        { numero: 1, nome: "Pickford", posicao: "Goleiro", idade: 33 }
    ]
},
{
    pais: "Espanha",
    grupo: "C",
    ranking_fifa: 5,
    jogadores: [
        { numero: 8, nome: "Pedri", posicao: "Meia", idade: 24 },
        { numero: 19, nome: "Yamal", posicao: "Atacante", idade: 19 },
        { numero: 7, nome: "Morata", posicao: "Atacante", idade: 34 },
        { numero: 4, nome: "Laporte", posicao: "Zagueiro", idade: 32 },
        { numero: 1, nome: "Simon", posicao: "Goleiro", idade: 30 }
    ]
},
{
    pais: "Portugal",
    grupo: "C",
    ranking_fifa: 6,
    jogadores: [
        { numero: 7, nome: "Cristiano Ronaldo", posicao: "Atacante", idade: 41 },
        { numero: 10, nome: "Bernardo Silva", posicao: "Meia", idade: 32 },
        { numero: 8, nome: "Bruno Fernandes", posicao: "Meia", idade: 33 },
        { numero: 3, nome: "Pepe", posicao: "Zagueiro", idade: 43 },
        { numero: 1, nome: "Diogo Costa", posicao: "Goleiro", idade: 28 }
    ]
},
{
    pais: "Alemanha",
    grupo: "D",
    ranking_fifa: 11,
    jogadores: [
        { numero: 8, nome: "Kimmich", posicao: "Meia", idade: 31 },
        { numero: 10, nome: "Musiala", posicao: "Meia", idade: 23 },
        { numero: 9, nome: "Havertz", posicao: "Atacante", idade: 28 },
        { numero: 2, nome: "Rudiger", posicao: "Zagueiro", idade: 34 },
        { numero: 1, nome: "Neuer", posicao: "Goleiro", idade: 40 }
    ]
},
{
    pais: "Uruguai",
    grupo: "D",
    ranking_fifa: 14,
    jogadores: [
        { numero: 8, nome: "Valverde", posicao: "Meia", idade: 28 },
        { numero: 9, nome: "Darwin Nunez", posicao: "Atacante", idade: 27 },
        { numero: 4, nome: "Araujo", posicao: "Zagueiro", idade: 28 },
        { numero: 6, nome: "Bentancur", posicao: "Meia", idade: 29 },
        { numero: 1, nome: "Rochet", posicao: "Goleiro", idade: 34 }
    ]
}
]);

db.partidas.insertMany([
{
    estadio: "MetLife Stadium",
    selecao_casa: "Brasil",
    selecao_visitante: "Uruguai",
    gols_casa: 2,
    gols_visitante: 0,
    data: ISODate("2026-06-15"),
    eventos: [
        { minuto: 15, jogador: "Neymar", tipo: "Gol" },
        { minuto: 80, jogador: "Vini Jr", tipo: "Gol" }
    ]
},
{
    estadio: "Azteca",
    selecao_casa: "Argentina",
    selecao_visitante: "Alemanha",
    gols_casa: 1,
    gols_visitante: 1,
    data: ISODate("2026-06-16"),
    eventos: [
        { minuto: 20, jogador: "Messi", tipo: "Gol" },
        { minuto: 70, jogador: "Kimmich", tipo: "Gol" }
    ]
},
{
    estadio: "AT&T Stadium",
    selecao_casa: "Franca",
    selecao_visitante: "Portugal",
    gols_casa: 2,
    gols_visitante: 2,
    data: ISODate("2026-06-17"),
    eventos: [
        { minuto: 10, jogador: "Mbappe", tipo: "Gol" },
        { minuto: 30, jogador: "Cristiano Ronaldo", tipo: "Gol" }
    ]
},
{
    estadio: "Rose Bowl",
    selecao_casa: "Inglaterra",
    selecao_visitante: "Espanha",
    gols_casa: 3,
    gols_visitante: 1,
    data: ISODate("2026-06-18"),
    eventos: [
        { minuto: 12, jogador: "Harry Kane", tipo: "Gol" },
        { minuto: 45, jogador: "Yamal", tipo: "Gol" }
    ]
},
{
    estadio: "MetLife Stadium",
    selecao_casa: "Brasil",
    selecao_visitante: "Franca",
    gols_casa: 3,
    gols_visitante: 2,
    data: ISODate("2026-06-21"),
    eventos: [
        { minuto: 5, jogador: "Neymar", tipo: "Gol" },
        { minuto: 40, jogador: "Mbappe", tipo: "Gol" },
        { minuto: 88, jogador: "Vini Jr", tipo: "Gol" }
    ]
},
{
    estadio: "Azteca",
    selecao_casa: "Argentina",
    selecao_visitante: "Uruguai",
    gols_casa: 2,
    gols_visitante: 0,
    data: ISODate("2026-06-22"),
    eventos: [
        { minuto: 34, jogador: "Messi", tipo: "Gol" },
        { minuto: 60, jogador: "Julian Alvarez", tipo: "Gol" }
    ]
},
{
    estadio: "AT&T Stadium",
    selecao_casa: "Portugal",
    selecao_visitante: "Alemanha",
    gols_casa: 1,
    gols_visitante: 0,
    data: ISODate("2026-06-23"),
    eventos: [
        { minuto: 89, jogador: "Cristiano Ronaldo", tipo: "Gol" }
    ]
},
{
    estadio: "Rose Bowl",
    selecao_casa: "Inglaterra",
    selecao_visitante: "Brasil",
    gols_casa: 2,
    gols_visitante: 2,
    data: ISODate("2026-06-24"),
    eventos: [
        { minuto: 15, jogador: "Harry Kane", tipo: "Gol" },
        { minuto: 70, jogador: "Rodrygo", tipo: "Gol" }
    ]
},
{
    estadio: "MetLife Stadium",
    selecao_casa: "Espanha",
    selecao_visitante: "Franca",
    gols_casa: 1,
    gols_visitante: 2,
    data: ISODate("2026-06-25"),
    eventos: [
        { minuto: 22, jogador: "Morata", tipo: "Gol" },
        { minuto: 50, jogador: "Griezmann", tipo: "Gol" }
    ]
},
{
    estadio: "Azteca",
    selecao_casa: "Uruguai",
    selecao_visitante: "Portugal",
    gols_casa: 0,
    gols_visitante: 1,
    data: ISODate("2026-06-26"),
    eventos: [
        { minuto: 42, jogador: "Bernardo Silva", tipo: "Gol" }
    ]
},
{
    estadio: "AT&T Stadium",
    selecao_casa: "Alemanha",
    selecao_visitante: "Inglaterra",
    gols_casa: 1,
    gols_visitante: 3,
    data: ISODate("2026-06-27"),
    eventos: [
        { minuto: 11, jogador: "Havertz", tipo: "Gol" },
        { minuto: 65, jogador: "Bellingham", tipo: "Gol" }
    ]
},
{
    estadio: "Rose Bowl",
    selecao_casa: "Argentina",
    selecao_visitante: "Brasil",
    gols_casa: 2,
    gols_visitante: 3,
    data: ISODate("2026-06-28"),
    eventos: [
        { minuto: 8, jogador: "Messi", tipo: "Gol" },
        { minuto: 54, jogador: "Neymar", tipo: "Gol" },
        { minuto: 82, jogador: "Vini Jr", tipo: "Gol" }
    ]
}
]);

