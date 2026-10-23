# GPS Nexus · Capacitação

Plataforma web de capacitação de uso exclusivo dos colaboradores das empresas do Grupo GPS: acesso por matrícula e senha, perfis de acesso, conteúdos protegidos, registro de navegação, administração e indicadores. Funciona em computador e celular.

## Rodar localmente (teste)
Requisito: Node.js 22.5 ou mais novo.
```
npm install
npm start            # http://localhost:8080
```
No primeiro início, o log mostra a senha temporária do usuário `admin`. Entre, troque a senha e, em **Administração › Conteúdos**, envie o arquivo `conteudos-iniciais/esteiras-lona.html` (título `Operação e diagnóstico de esteiras de lona · Nível 1`, identificador `esteiras-lona`, 6 avaliações). Depois, em **Agenda**, libere o conteúdo e, em **Usuários**, cadastre os colaboradores.

## Produção
1. Publicar atrás de HTTPS (Nginx, Caddy, Azure App Service, AWS etc.). Nunca expor a porta 8080 diretamente.
2. Copiar `.env.example` para `.env` e preencher; `COOKIE_SECURE=1` e `TRUST_PROXY=1`.
3. `docker build -t gps-nexus .` e `docker run -d --env-file .env -p 127.0.0.1:8080:8080 -v nexus-dados:/dados -v nexus-conteudos:/conteudos gps-nexus`
4. Fazer backup diário dos volumes `/dados` (banco) e `/conteudos`.
5. Ler `docs/ARQUITETURA.md` (segurança, LGPD e próximos passos).

## Estrutura
- `server/` — servidor (código nunca é enviado ao navegador)
- `public/` — telas da plataforma (entrada, capacitações, administração, indicadores)
- `conteudos/` — treinamentos enviados pelo administrador (servidos só com sessão e liberação)
- `dados/` — banco SQLite (trocar por PostgreSQL quando passar de alguns milhares de usuários)

## Versões
- 1.1 (23/10/2026): treinamento "Operação e diagnóstico de esteiras de lona · Nível 1" (v2.32).
- 1.0 (23/10/2026): primeira versão da plataforma.
