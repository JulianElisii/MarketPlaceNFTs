// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import './ERC721Connector.sol';

contract Token is ERC721Connector {

  // matriz para guardar nuestros nfts
    string[] public TokenNFTS;

    mapping(string => bool) _TokenNFTExists;

    function mint(string memory _Token) public {

        require(!_TokenNFTExists[_Token], 'Error - token already exists');

        TokenNFTS.push(_Token);
        uint _id = TokenNFTS.length -1;

        _mint(msg.sender, _id);

        _TokenNFTExists[_Token] = true;
    }
    /*Funcion mint: le paso el token que voy a  mintear
    luego verifico que ese Token no exista, luego hago un push
    al array 'TokenNFTS' con esew token, luego le doy valor al _id,
    despues utilizo la funcion _mint de ERC721.sol pasandole como paramentro
     el address y el _id del token que viene de la pocision del array,
     despues vamos a decirle que ese _token ya fue creado indicandole
      que es true. */

    constructor() ERC721Connector('Pilicoin', 'KT') {
       
    }


}

 /*creamos el Token en el en token.sol luego pasamos esa informacion a
   Erc721Connector.sol para 'conectar' esa informacion con ERC721Metadata.sol y asi 
   tranformar el 'token'(contrato) en un PROTOCOLO Erc721 o token ERC721*/