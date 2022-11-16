// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import './interfaces/IERC721Metadata.sol';
import './ERC165.sol';

contract ERC721Metadata is IERC721Metadata, ERC165 {
    string private _name;
    string private _symbol;

    constructor(string memory named, string memory symbolified) {

        _registerInterface(bytes4(keccak256('name(bytes4)')^
        keccak256('symbol(bytes4)')));

        _name = named;
        _symbol= symbolified;
    }


     function name() external view returns(string memory) {
        return _name;
    }
   
    function symbol() external view returns(string memory) {
        return _symbol;
    }

    /*creamos el Token en el en token.sol luego pasamos esa informacion a
     Erc721Connector.sol para 'conectar' esa informacion con ERC721Metadata.sol y asi 
     tranformar el 'token'(contrato) en un PROTOCOLO Erc721 o token ERC721*/


}

