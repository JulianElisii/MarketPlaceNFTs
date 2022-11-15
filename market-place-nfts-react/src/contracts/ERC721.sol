// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import './ERC165.sol';
import './interfaces/IERC721.sol';
import './libraries/Counters.sol';

contract ERC721 is ERC165, IERC721 {
    using SafeMath for uint256; 
    using Counters for Counters.Counter;

    mapping(uint256 => address) private _tokenOwner;

    mapping(address => Counters.Counter) private _ownedTokensCount;

    // direccion verificar tokens aprovados
    mapping(uint256 => address) private _tokenApprovals;

      constructor() {
        _registerInterface(bytes4(keccak256('balanceOf(bytes4)')^
        keccak256('ownerOf(bytes4)')^keccak256('transferFrom(bytes4)')));
    }
     
    
    //cuantos token tiene esa direccion //balance de tokens.
    function balanceOf(address _owner) public override view returns (uint256){
        require (_owner != address(0), 'Address is zero');
        return _ownedTokensCount[_owner].current();
    }

    //quien es dueño de este token.
    function ownerOf(uint256 _tokenId) public override view returns (address){
        address owner = _tokenOwner[_tokenId];
        require (owner != address(0), 'Address is zero');
        return owner;
    }



      function _exists(uint256 tokenId) internal view returns(bool){
        address owner = _tokenOwner[tokenId];
        return owner != address(0); 
    }

    function _mint(address to, uint256 tokenId) internal virtual {
        // revisar que el address no sea cero!
        require(to != address(0), 'ERC721 minting to zero address');

        // tokenId No debe existir anteriormente
        require(!_exists(tokenId), 'ERC721 already exists');

        //Apuntar a direccoin del dueño
        _tokenOwner[tokenId] = to; //decimos que este token(Nft) nuevo es de este dueño(to) 

        // Cuantos tokens tiene ese dueño(to) le pasamos el (to) e incrementamos la cantidad en 1 de tokens que tiene esa direccion.
        _ownedTokensCount[to].increment();

        emit Transfer(address(0), to, tokenId);
    }

    // debemos llamar esta funcion para aumentar seguridad
    function _transferFrom(address _from, address _to, uint256 _tokenId) internal {
        require(_to != address(0), 'Error - ERC721 Transfer to the zero address');
        require(ownerOf(_tokenId) == _from, 'Trying to transfer a token the address does not own!');

        _ownedTokensCount[_from].decrement();
        _ownedTokensCount[_to].increment();

        _tokenOwner[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }


    function transferFrom(address _from, address _to, uint256 _tokenId) override public {
        require(isApprovedOrOwner(msg.sender, _tokenId));
        _transferFrom(_from, _to, _tokenId);
    }


    
    function approve(address _to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(_to != owner, 'Error - approval to current owner');
        require(msg.sender == owner, 'Current caller must be owner');
        _tokenApprovals[tokenId] = _to;
        emit Approval(owner, _to, tokenId);
    }

    function isApprovedOrOwner(address spender, uint256 tokenId) internal view returns(bool){
        require(_exists(tokenId), 'token does not exist');
        address owner = ownerOf(tokenId);
        return(spender == owner); 
    }

    //Poner override en ownerOf y BalanceOf

}