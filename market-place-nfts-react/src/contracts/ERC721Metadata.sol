// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract ERC721Metadata {
    string private _name;
    string private _symbol;

    constructor(string memory named, string memory symbolified) {
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

