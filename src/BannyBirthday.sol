// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "@rari-capital/solmate/src/tokens/ERC721.sol";

contract BannyBirthday is ERC721 {

uint256 public totalSupply;
string metadata;

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _projectId,
        address _beneficiary
        string memory _metadata
    )
        ERC721(_name, _symbol)
        JBETHERC20ProjectPayer(
            _projectId,
            payable(_beneficiary),
            false,
            "happy birthday Banny!",
            "",
            false,
            IJBDirectory(0xCc8f7a89d89c2AB3559f484E0C656423E979ac9C),
            address(this)
        )
    {metadata = _metadata}

    function mint() external {
        require(msg.value>0.001, "must donate moar");
            _pay(
                projectId, //uint256 _projectId,
                JBTokens.ETH, // address _token
                msg.value, //uint256 _amount,
                18, //uint256 _decimals,
                msg.sender, //address _beneficiary,
                0, //uint256 _minReturnedTokens,
                false, //bool _preferClaimedTokens,
                "happy birthday Banny!", //string calldata _memo, TODO Swap this for IPFS of the bday image
                "" //bytes calldata _metadata
            );
        unchecked{++totalSupply}
        _mint(msg.sender, totalSupply)
    }

    function tokenUri(tokenId) public view returns(string){
        return metadata;
    }

}
