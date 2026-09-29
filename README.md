# Censo de Aves Marinhas — protótipo Flutter

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

## Como instalar no seu projeto

Se você já criou o projeto Flutter `primeiro`, copie a pasta `lib/` deste protótipo para dentro dele e substitua o `pubspec.yaml` pelas dependências equivalentes, ou use este diretório como base de um novo projeto.

No terminal do VS Code:

```bash
flutter pub get
flutter run -d chrome
```

Para Android:

```bash
flutter devices
flutter run
```

## Permissão de localização no Android

Para o GPS funcionar no Android, adicione antes de `<application>` em `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

Na Web, o navegador pedirá autorização para usar a localização.

## Observação sobre o armazenamento

Nesta primeira versão, o catálogo de espécies usa `shared_preferences` e JSON. Isso é intencional para o mesmo código funcionar no navegador e no celular durante o protótipo.

Para produção, recomendamos manter a interface `EspeciesRepository` e trocar apenas sua implementação por um banco remoto/servidor. Assim as telas não precisam ser reescritas.

## O que ainda é protótipo

- O código de confirmação ainda não consulta servidor.
- Os campos de cadastro/campanha/dados do comando ainda precisam ser persistidos.
- O temporizador mostra o tempo, mas ainda não bloqueia automaticamente ações ao zerar.
- O GPS registra rota enquanto a tela/app mantém o stream ativo; rastreamento robusto em segundo plano exige projeto específico para Android/iOS.
- A tela administrativa permite cadastrar espécie, mas a ação de converter uma `Sp. nova` pendente em espécie validada será a próxima etapa.
- A sincronização entre vários observadores ainda não foi implementada.

## Pacotes

- `provider`: estado compartilhado do aplicativo.
- `shared_preferences`: persistência local simples e compatível com Web.
- `geolocator`: GPS/localização.
- `flutter_map`: mapa.
- `latlong2`: coordenadas do mapa.
