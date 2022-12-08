//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

// Website: https://arbitrumbook.io
// Twitter: https://twitter.com/ArbitrumBook
// Documentation: https://docs.arbitrubook.io

//                                    %&&&/
//                                .&&&&&&&&&&/
//                             &&&&&&%%%%%%%&&&&/
//                         &&&&&&%%%%%%%%%%%%%%&&&%*
//                     *%%%&&%%%%%%%%%%%%%%%%%%%%%%%%%,
//                  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&,
//              &&&&&&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#&&&&.
//          #&&&&&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%########&&&&.
//       &&&&&&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%###############&&&&
//   &&&&&&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%############&&&&&&
//   &&&&&&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#########&&&&&&//
//   &&&&*&&&&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%###%&&&&&#////**
//   &&&..,,/&&&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&&&////*****@
//   &&&&...,,*/%%%%%%%%%%%%%#####%%%%%%%%%%%%%%%%***/*****%&&&@@@@
//   &&&&&&%..,,**/%%%%%%#############%%%&&&&&**********&&&@@@@@@
//      &&&&%%%,,,,**/&&&&##########%&&&&&&(((#********@@@@@@
//         &&&&%%%,,,**/(&&&&####&&&&&&////**/(((**####@@.
//            &&&&%%&,,***/(&&&&&&&(///*****/&&&@######
//               &&&&&&&****///%////*****&&&@@@@@######
//                  @&@@&&&**********&&&@@@@@@   ##%%%%
//                     @@@@&&&***(&&&@@@@@(      %%%%%%
//                        @@@@&&&@@@@@@          %%%%%%
//                           @@@@@@              %

contract pBook is ERC20Burnable, Ownable {
    using SafeMath for uint256;

    address public presaleContract;

    constructor() ERC20("PresaleBook", "pBook") {}

    modifier onlyPresale() {
        require(msg.sender == presaleContract);
        _;
    }

    function setPresaleContract(address presaleContract_) external onlyOwner {
        require(presaleContract_ != address(0), "The address can not be 0");
        presaleContract = presaleContract_;
    }

    function mint(address _recipient, uint256 _amount) external onlyPresale {
        _mint(_recipient, _amount);
    }

    function governanceRecoverUnsupported(
        IERC20 _token,
        uint256 _amount,
        address _to
    ) external onlyOwner {
        _token.transfer(_to, _amount);
    }
}
