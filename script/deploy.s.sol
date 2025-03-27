pragma solidity ^0.6.12;

import "forge-std/Script.sol";
import {Dai} from "../src/dai.sol";
import {Vat} from "../src/vat.sol";
import {DaiJoin} from "../src/join.sol";
import {Jug} from "../src/jug.sol";
import {Vow} from "../src/vow.sol";
import {Flapper} from "../src/flap.sol";
import {Flopper} from "../src/flop.sol";

contract Deploy is Script {
    address public daiAddress;
    address public vatAddress;
    address public daiJoinAddress;
    address public jugAddress;
    address public vowAddress;
    address public flapAddress;
    address public flopAddress;

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        Vat vat = _deployVat();
        Dai dai = _deployDai(uint256(vm.envUint("CHAIN_ID")));
        DaiJoin daiJoin = _deployDaiJoin(address(vat), address(dai));
        Jug jug = _deployJug(address(vat));
        Flapper flap = _deployFlap(address(vat), address(dai));
        Flopper flop = _deployFlop(address(vat), address(dai));
        Vow vow = _deployVow(address(vat), address(flap), address(flop));

        vatAddress = address(vat);
        daiAddress = address(dai);
        daiJoinAddress = address(daiJoin);
        jugAddress = address(jug);
        flapAddress = address(flap);
        flopAddress = address(flop);
        vowAddress = address(vow);

        vat.rely(address(daiJoin));
        vat.rely(address(jug));
        vat.rely(address(flap));
        vat.rely(address(flop));
        vat.rely(address(vow));
        jug.rely(address(this));
        vow.rely(address(this));

        vm.stopBroadcast();

        console.log("Vat deployed at:", vatAddress);
        console.log("Dai deployed at:", daiAddress);
        console.log("DaiJoin deployed at:", daiJoinAddress);
        console.log("Jug deployed at:", jugAddress);
        console.log("Flap deployed at:", flapAddress);
        console.log("Flop deployed at:", flopAddress);
        console.log("Vow deployed at:", vowAddress);
    }

    function _deployVat() internal returns (Vat) {
        Vat vat = new Vat();
        return vat;
    }

    function _deployDai(uint256 chainId) internal returns (Dai) {
        Dai dai = new Dai(chainId);
        return dai;
    }

    function _deployDaiJoin(address vat_, address dai_) internal returns (DaiJoin) {
        DaiJoin daiJoin = new DaiJoin(vat_, dai_);
        return daiJoin;
    }

    function _deployJug(address vat_) internal returns (Jug) {
        Jug jug = new Jug(vat_);
        return jug;
    }

    function _deployFlap(address vat_, address gem_) internal returns (Flapper) {
        Flapper flap = new Flapper(vat_, gem_);
        return flap;
    }

    function _deployFlop(address vat_, address gem_) internal returns (Flopper) {
        Flopper flop = new Flopper(vat_, gem_);
        return flop;
    }

    function _deployVow(address vat_, address flap_, address flop_) internal returns (Vow) {
        Vow vow = new Vow(vat_, flap_, flop_);
        return vow;
    }
}
