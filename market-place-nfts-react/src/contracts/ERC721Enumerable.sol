// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import './ERC721.sol';

contract ERC721Enumerable is ERC721 {
  uint []  private _allTokens;

   // Mapa para identificar la posicion del tokenId en matriz
    mapping(uint256 => uint256) private _allTokensIndex;

    // Mapa del dueño a lista de todos los tokenId que el es dueño
    mapping(address => uint256[]) private _ownedTokens;

    // Mapa de tokenId a indice de la lista de tokens del propietario
    mapping(uint256 => uint256) private _ownedTokensIndex;

  function _mint(address to, uint256 tokenId) internal override(ERC721){
        super._mint(to, tokenId);
        // A. agregar tokens al dueño.
        _addTokensToOwnerEnumeration(to, tokenId);
        // B. agregar tokens al totalsupply.
         _addTokensToAllTokenEnumeration(tokenId);
    }

     // agregar tokens a la matriz _allTokens
    function _addTokensToAllTokenEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private {
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }

    // Retornar tokenPorIndice
    function tokenByIndex(uint256 index) public  view returns(uint256) {
        require(index < totalSupply(), 'Global index out of bounds');
        return _allTokens[index];
    }

    function tokenOfOwnerByIndex(address owner, uint256 index) public  view returns(uint256) {
        require(index < balanceOf(owner), 'Owner index out of bounds');
        return _ownedTokens[owner][index];
    }

     function totalSupply() public view returns(uint256) {
        return _allTokens.length;

    }


//0x666c91015c46df1e63637ac4f5f2551a72181fa6
  


}