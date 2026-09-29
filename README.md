# Censo de Aves Marinhas
Protótipo didático baseado no fluxo definido para campanhas embarcadas.

## Fluxo implementado

Boas-vindas → Cadastro do observador → Confirmação → Campanha → Censo N → Dados do comando → Aves seguidoras → Censo contínuo → Censo instantâneo → Finalização → intervalo de 30 min / início manual do próximo censo.

## Regras já representadas

- O número do censo identifica o ciclo completo.
- Cada censo executa os três métodos: seguidoras, contínuo e instantâneo.
- Dados do comando são preenchidos novamente a cada censo.
- Censo contínuo tem janela de 10 minutos.
- Censo instantâneo possui 10 contagens; a tela controla a rodada 1 a 10.
- Em cada espécie, `+` e `-` alteram a quantidade atual; o campo também aceita digitação direta (ex.: 12 aves de uma vez).
- O botão ADICIONAR soma a quantidade ao total observado daquela espécie.
- `Sp. nova` pode ser criada como identificação pendente.
- O administrador pode adicionar espécies ao catálogo.
- Data/hora são obtidas com `DateTime.now()`.
- Ao finalizar, o próximo censo fica previsto para 30 minutos depois, mas pode ser iniciado imediatamente.
- A tela de mapa registra posições GPS e desenha a rota já percorrida.


