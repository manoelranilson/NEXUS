FROM node:22-alpine
ENV NODE_ENV=production
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm ci --omit=dev || npm install --omit=dev
COPY server ./server
COPY public ./public
RUN addgroup -S nexus && adduser -S nexus -G nexus && mkdir -p /dados /conteudos && chown -R nexus:nexus /dados /conteudos
USER nexus
ENV NEXUS_DB=/dados/nexus.db NEXUS_CONTEUDOS=/conteudos PORT=8080
VOLUME ["/dados", "/conteudos"]
EXPOSE 8080
CMD ["node", "--no-warnings", "server/server.js"]
