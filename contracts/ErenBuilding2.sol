// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
//import "./IWhitelist.sol";

//interface tem como objetivo pegar a funcao whitelisteAddresses
interface IWhitelist {
    function whitelistedAddresses(address) external view returns (bool);
}

contract ErenBuilding is ERC721Enumerable, Ownable {
    /**
      * @dev _baseTokenURI for computing {tokenURI}. If set, the resulting URI for each
      * token will be the concatenation of the `baseURI` and the `tokenId`.
      */
    string _baseTokenURI;

    // limita o numero de TokensIds
    uint256 public maxTokenIds = 10;

    // numero total de tokenIds mintados
    uint256 public tokenIds;

    // instancia o contrato Whitelist
    IWhitelist whitelist;

    // modifier pode resolver? []
    // modifier onlyWhenNotPaused {
    //     require(!_paused, "Contract currently paused");
    //     _;
    // }

    /*
        baseURI - enderecamento base - que sera usado para concatenar cada tokeURI
        whitelisContract - o endereco do whitelist sera instanciado e utilizado a parte
    */
    constructor (string memory baseURI, address whitelistContract) ERC721("Eren Building", "EREN") {
        _baseTokenURI = baseURI;
        whitelist = IWhitelist(whitelistContract);
    }

    /**
    * mint() - funcao mais importante - publica, mas apenas quem esta no whitelist pode
    mintar;
    [] checagem se a mintagem atual nao ira ultrapassar o numero maximo de tokensIds
    redundancia > seguranca;
    [] checagem se o msg.sender esta presente na lista whitelist
    incremento dos tokensIds;
    _safeMint() - garante que a carteira que ira receber e compativel com o erc721, 
    caso contrario reverte
    */
    function mint() public {
        require(tokenIds < maxTokenIds, "Exceed maximum Crypto Devs supply");
        require(whitelist.whitelistedAddresses(msg.sender), "You are not whitelisted");
        tokenIds += 1;
        _safeMint(msg.sender, tokenIds);
    }

    // \/--------- FUNCOES ORIGINAIS -------- \/

    /**
    * @dev _baseURI overides the Openzeppelin's ERC721 implementation which by default
    * returned an empty string for the baseURI
    */
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    /**
    * @dev withdraw sends all the ether in the contract
    * to the owner of the contract
      */
    function withdraw() public onlyOwner  {
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent, ) =  _owner.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}
}