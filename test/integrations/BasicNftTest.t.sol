// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployBasicNft} from "script/DeployBasicNft.s.sol";
import {BasicNft} from "src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant SHIBA_INU =
        "https://bafybeie5venjwpgkqpthezwtyrm7bqm5wzkiukcvqdyftd4behdamkw3re.ipfs.dweb.link?filename=shiba-inu.png";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        assertEq(basicNft.name(), "Dogie"); // This assret and the one below are the same but assertEq is a foundry Keyword for testing envioment
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveABAlance() public {
        vm.prank(USER);
        basicNft.mintNft(SHIBA_INU);
        assert(basicNft.balanceOf(USER) == 1);
        assert(
            sha256(abi.encodePacked(SHIBA_INU)) ==
                sha256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}
