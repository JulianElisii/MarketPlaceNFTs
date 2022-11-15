// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import './ERC721Metadata.sol';
import './ERC721Enumerable.sol';

contract ERC721Connector is ERC721Metadata, ERC721Enumerable { //aqui heredamos datos de ERC721Metadata

    // desplegamos el connector
    // queremos alimentar los metadatos
    constructor(string memory name, string memory symbol) ERC721Metadata(name, symbol){

    }
}


 /*creamos el Token en el en token.sol luego pasamos esa informacion a
   Erc721Connector.sol para 'conectar' esa informacion con ERC721Metadata.sol y asi 
   tranformar el 'token'(contrato) en un PROTOCOLO Erc721 o token ERC721*/