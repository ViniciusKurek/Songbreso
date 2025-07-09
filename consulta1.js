// Consulta 1: Encontra todos os usuários que também são artistas.
// Demonstra um JOIN simples para identificar usuários com múltiplos papéis.
import { PrismaClient } from "./generated/prisma/index.js"

const prisma = new PrismaClient()

async function main() {
  const result = await prisma.user.findMany({
    select: {
      name: true, // user_name
      user_is_artist: {
        select: {
          artist: {
            select: {
              pseudonym: true, // artist_pseudonym
            },
          },
        },
      },
    },
  });
  
  // Formatando o resultado para corresponder à sua query SQL
  const formattedResult = result.flatMap(user =>
    user.user_is_artist.map(uia => ({
      user_name: user.name,
      artist_pseudonym: uia.artist.pseudonym,
    }))
  );
  
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