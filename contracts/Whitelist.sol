//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;


contract Whitelist {

    // Numero maximo de enderecos: um endereco por apartamento
    uint8 public maxWhitelistedAddresses;
    //valor do apartamento - a titulo de exemplo - 0.001 ether
    uint256 public apartPrice;

    // Cria um mapping de enderecos no whitelist
    // Se o usuario estiver listado ele recebe true no mapping
    mapping(address => bool) public whitelistedAddresses;

    // sera usada para saber quantas variaveis foram criadas
    uint8 public numAddressesWhitelisted;
    //apartPrice = 0.001 ether;

    // No constructor se criara todos os numeros maximos
    constructor(uint8 _maxWhitelistedAddresses, uint256 _apartPrice) {
        maxWhitelistedAddresses =  _maxWhitelistedAddresses;
        apartPrice = _apartPrice;
    }

    /**
        addAddressToWhitelist - funcao permite ao msg.sender se juntar na lista whitelist
     */
    function addAddressToWhitelist() public payable {
        // chega se o usuario nao esta na lista
        require(!whitelistedAddresses[msg.sender], "Sender has already been whitelisted");
        // checa se o numero maximo nao foi atingindo
        require(numAddressesWhitelisted < maxWhitelistedAddresses, "More addresses cant be added, limit reached");
        //checa se o valor que o usuario passou e o valor minimo
        require(msg.value >= apartPrice, "Ether sent is not the apartment price");
        // adiciona o endereco na funcao como true
        whitelistedAddresses[msg.sender] = true;
        // Increase the number of whitelisted addresses
        numAddressesWhitelisted += 1;
    }

}