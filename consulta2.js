import { PrismaClient } from "./generated/prisma/index.js"
const prisma = new PrismaClient()

// Consulta 2: Mostra todos os artistas e o número de álbuns que cada um lançou.
// Esta consulta usa GROUP BY e COUNT para agregar dados por artista,
// fornecendo uma visão geral da produtividade de cada artista em termos de álbuns.
async function main() {
    const result = await prisma.artist.findMany({
        select: {
          pseudonym: true,
          _count: {
            select: {
              album: true,
            },
          },
        },
        orderBy: {
          album: {
            _count: 'desc',
          },
        },
      });
      
      const formattedResult = result.map(artist => ({
        artist_pseudonym: artist.pseudonym,
        number_of_albums: artist._count.album,
      }));
      
      console.log(formattedResult);
}



main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error(e)
    await prisma.$disconnect()
    process.exit(1)
  })