// Consulta 3: Lista todas as músicas em uma playlist específica, incluindo o nome do álbum (se houver).
// Esta consulta envolve JOINs entre Playlist, Playlist_has_Music, Music e Album,
// agregando informações sobre músicas e seus álbuns dentro de uma playlist.
// Substitua '1' pelo ID da playlist desejada.
import { PrismaClient } from "./generated/prisma/index.js"
const prisma = new PrismaClient()

async function main() {const playlistIdToSearch = 1;

    const result = await prisma.playlist.findUnique({
      where: {
        id_playlist: playlistIdToSearch,
      },
      select: {
        name: true, 
        playlist_has_music: {
          select: {
            added_at: true, 
            music: {
              select: {
                name: true, 
                album: {
                  select: {
                    title: true, 
                  },
                },
              },
            },
          },
        },
      },
    });
    
    const formattedResult = result?.playlist_has_music.map(phm => ({
      playlist_name: result.name,
      music_name: phm.music.name,
      album_title: phm.music.album?.title || null,
      added_at: phm.added_at,
    })) || [];
    
    console.log(formattedResult);};

main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error(e)
    await prisma.$disconnect()
    process.exit(1)
  })