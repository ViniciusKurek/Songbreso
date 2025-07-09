# Banco-de-Dados

Projeto de Plataforma de Compartilhamento de Músicas
Grupo: Songbreso

Link para o github: `https://github.com/ViniciusKurek/Songbreso`

Link para o overleaf: `https://pt.overleaf.com/6326966831nngmtqhdkdfc#375a0a`

Link para o Modelo ER: `https://drive.google.com/file/d/1sgUuAMdQHwb2kHLKA7F6BKlqeqpL87kN/view?usp=drive_link`

---

## Instalação

### Requisitos

- Node
- NPM
- GIT

### Passo a passo

Clonar repositório

```sh
git clone https://github.com/ViniciusKurek/Songbreso.git
cd Songbreso
```

Instalar pacotes

```sh
npm install
```

Criar banco de dados Postgres e executar o arquivo `projeto_bd.sql` para criar as tabelas e inserir os dados

Adicionar arquivo .env

```sh
cp .env.exemplo .env
```

Alterar o valor da chave `DATABASE_URL` do arquivo `.env` com os dados de conexão do banco de dados

Gerar modelos do prisma

```sh
npx prisma generate
```

### Executando consultas

Executar consulta 1
```sh
npm run consulta1
```

Executar consulta 2
```sh
npm run consulta2
```

Executar consulta 3
```sh
npm run consulta3
```
