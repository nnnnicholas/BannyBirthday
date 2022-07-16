// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

import "@rari-capital/solmate/src/tokens/ERC721.sol";
import "@jbx-protocol/contracts-v2/contracts/JBETHERC20ProjectPayer.sol";

contract BannyBirthday is ERC721, JBETHERC20ProjectPayer {
    uint256 public totalSupply;
    string private metadata;
    uint256 private immutable deadline;
    uint256 private immutable projectId;

    constructor(
        string memory _name,
        string memory _symbol,
        address _jbdirectory,
        uint256 _projectId,
        address _beneficiary,
        string memory _metadata,
        uint256 _deadline // 1657972800 last time it'll be July 15 anywhere in the world
    )
        ERC721(_name, _symbol)
        JBETHERC20ProjectPayer(
            _projectId,
            payable(_beneficiary),
            false,
            "happy birthday Banny! https://jbx.mypinata.cloud/ipfs/QmTLnhYt7vMe8Zhui7WZjgiFjZwFWicnS2KLMFUtzJLtgW",
            "",
            false,
            IJBDirectory(_jbdirectory),
            address(this)
        )
    {
        projectId = _projectId;
        metadata = _metadata;
        deadline = _deadline;
    }

    function mint() external payable {
        require(msg.value >= 0.001 ether, "must donate moar");
        require(block.timestamp < deadline);
        _pay(
            projectId, //uint256 _projectId,`
            JBTokens.ETH, // address _token
            msg.value, //uint256 _amount,
            18, //uint256 _decimals,
            msg.sender, //address _beneficiary,
            0, //uint256 _minReturnedTokens,
            false, //bool _preferClaimedTokens,
            "happy birthday Banny! https://jbx.mypinata.cloud/ipfs/QmTLnhYt7vMe8Zhui7WZjgiFjZwFWicnS2KLMFUtzJLtgW", //string calldata _memo, TODO Swap this for IPFS of the bday image
            "" //bytes calldata _metadata
        );
        unchecked {
            ++totalSupply;
        }
        _mint(msg.sender, totalSupply);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override(ERC721)
        returns (string memory)
    {
        return metadata;
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, JBETHERC20ProjectPayer)
        returns (bool)
    {
        return
            JBETHERC20ProjectPayer.supportsInterface(interfaceId) ||
            ERC721.supportsInterface(interfaceId);
    }
}
