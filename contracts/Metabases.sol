pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract Metabases is ERC721Enumerable, Ownable {
    
    using Strings for uint256;

    string public METABAES_PROVENANCE = ""; // IPFS URL WILL BE ADDED WHEN METABAES ARE ALL SOLD OUT

    string public LICENSE_TEXT = ""; // IT IS WHAT IT SAYS

    bool licenseLocked = false; // TEAM CAN'T EDIT THE LICENSE AFTER THIS GETS TRUE

    uint256 public constant metabaesPrice = 25000000000000000; // 0.025 ETH

    uint public constant maxMetabaesPurchase = 20;

    uint256 public constant MAX_METABAES = 7777;

    mapping (uint256 => string) private _tokenURIs;

    mapping(uint => string) public metabaesNames;

    uint public metabaesReserve = 125;

    event metabaesNameChange(address _by, uint _tokenId, string _name);
    
    event licenseisLocked(string _licenseText);

    string private _baseURIextended;

    constructor(string memory _name, string memory _symbol)
        ERC721(_name, _symbol)
    {}

    function setBaseURI(string memory baseURI_) external onlyOwner() {
        _baseURIextended = baseURI_;
    }

    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseURIextended;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory _tokenURI = _tokenURIs[tokenId];
        string memory base = _baseURI();

        if (bytes(base).length == 0) {
            return _tokenURI;
        }

        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(base, _tokenURI));
        }

        return string(abi.encodePacked(base, tokenId.toString()));
    }

    function mint(
        address _to,
        uint256 _tokenId,
        string memory tokenURI_
    ) external onlyOwner() {
        _mint(_to, _tokenId);
        _setTokenURI(_tokenId, tokenURI_);
    }

    function mintMetabaes(uint numberOfTokens) public payable {
        // require(saleIsActive, "Sale must be active to mint METABAES");
        require(numberOfTokens > 9 && numberOfTokens <= maxMetabaesPurchase, "Can only mint 20 tokens at a time");
        // require(totalSupply().add(numberOfTokens) <= MAX_METABAES, "Purchase would exceed max supply of Metabaes");
        // require(msg.value >= metabaesPrice.mul(numberOfTokens), "Ether value sent is not correct");
        
        for(uint i = 0; i < numberOfTokens; i++) {
            uint mintIndex = totalSupply();
            if (totalSupply() < MAX_METABAES) {
                _safeMint(msg.sender, mintIndex);
            }
        }
    }
}