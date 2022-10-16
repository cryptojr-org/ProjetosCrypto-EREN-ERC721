# Configurando Ambiente Local

- Pré requisito
    - Visual Studio Code
    - Node JS

1. Instalando NPM

Abra o CMD ( Windows + R ) e instale o gerenciador de pacotes do Node.js ( NPM ) na pasta que irá trabalhar

```jsx
npm init -y
```

2. Instalando Hardhat

No CMD na pasta que irá trabalhar inicialize:

```jsx
npm install --save-dev hardhat
```

3. Inicialize Hardhat

```jsx
npx hardhat
```

- Create Javascript project
- Selecione a pasta correta
- Adicione git ignore

4. Instale outras dependências

```jsx
Copie o código que aparece no seu terminal " npm install ........... @nomiclabs. ..
```

5. Instale OpenZeppelin

```jsx
npm install @openzeppelin/contracts
```

### Rode ( para fins de teste )

*Compilando o contrato que o Hardhat fez:*

```jsx
npx hardhat compile
```

*Deployando o contrato que o Hardhat fez:*

```jsx
npx hardhat run scripts/deploy.js
```

*Importante:*

- Delete arquivo em scripts
- Delete arquivo em test
- Create em scripts → deploy.js