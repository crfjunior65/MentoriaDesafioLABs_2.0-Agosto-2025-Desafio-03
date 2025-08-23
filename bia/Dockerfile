FROM public.ecr.aws/docker/library/node:22-slim

# Instalar npm específico com versionamento
RUN npm install -g npm@11.0.0 --loglevel=error

# Instalando curl com versionamento e sem pacotes recomendados
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl=7.74.* && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

# Copiar package.json raiz primeiro
COPY package*.json ./
RUN npm install --loglevel=error

# Copiar package.json do client e instalar dependências
COPY client/package*.json ./client/
WORKDIR /usr/src/app/client
RUN npm install --legacy-peer-deps --loglevel=error

# Voltar ao diretório raiz e copiar todos os arquivos
WORKDIR /usr/src/app
COPY . .

# Build do front-end com Vite
WORKDIR /usr/src/app/client
RUN VITE_API_URL=https://formacao.bia-aws.com.br npm run build

# Limpeza das dependências de desenvolvimento
RUN npm prune --production && \
    rm -rf node_modules/.cache

# Voltar ao diretório raiz da aplicação
WORKDIR /usr/src/app

EXPOSE 8080

CMD [ "npm", "start" ]
