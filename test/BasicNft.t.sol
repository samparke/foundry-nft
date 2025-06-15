// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft basicNft;

    address public USER = makeAddr("user");
    string public constant redSentinal = "ipfs://Qmb8KXsiUq42fwki1NPpxHMs1CtemBzEhur2mG3gzRf8Px";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expected = "Superhero";
        string memory actual = basicNft.name();

        assertEq(expected, actual);
    }

    function testSymbolIsCorrect() public view {
        string memory expected = "SUPER";
        string memory actual = basicNft.symbol();

        assertEq(expected, actual);
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(redSentinal);

        assertEq(basicNft.balanceOf(USER), 1);
        assertEq(basicNft.tokenURI(0), redSentinal);
    }
}
