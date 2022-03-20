// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// https://github.com/aurora-is-near/aurora-examples/blob/main/truffle/erc721-example/contracts/CovidVaccineToken.sol

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Token is ERC721URIStorage {
    uint256 private _tokensCount = 0;
    address public minter = address(0);

    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);


    modifier onlyMinter(){
        require(
            minter == msg.sender,
            'Invalid Minter'
        );
        _;
    }

    constructor() ERC721("Token", "TST") {
        minter = msg.sender;
    }

    function mint(address to) external onlyMinter {
        uint256 tokenId = _tokensCount + 1;
        _mint(to, tokenId);
        _tokensCount = tokenId;
    }

    function burn(uint256 tokenId) external {
        _burn(tokenId);
        _tokensCount -= 1;
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public virtual override {
        require(minter == msg.sender || to == minter, 'Invalid Transfer');
        safeTransferFrom(from, to, tokenId, "");
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public virtual override {
        require(minter == msg.sender || to == minter, 'Invalid Transfer');
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");
        _safeTransfer(from, to, tokenId, _data);
    }
}
