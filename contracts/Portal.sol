// Copyright (C) 2020 Cartesi Pte. Ltd.

// SPDX-License-Identifier: GPL-3.0-only
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free Software
// Foundation, either version 3 of the License, or (at your option) any later
// version.

// This program is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
// PARTICULAR PURPOSE. See the GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

// Note: This component currently has dependencies that are licensed under the GNU
// GPL, version 3, and so you should treat this component as a whole as being under
// the GPL version 3. But all Cartesi-written code in this component is licensed
// under the Apache License, version 2, or a compatible permissive license, and can
// be used independently under the Apache v2 license. After this component is
// rewritten, the entire component will be released under the Apache v2 license.

/// @title Validator Manager
pragma solidity ^0.7.0;

interface Portal {

    // Ether - deposits/withdrawal of ether
    // ERC20 - deposit/withdrawal of ERC20 compatible tokens
    // Generic - deposit/withdrawal of generic assets, understandable offchain only
    enum operationType { EtherOp, ERC20Op, GenericOp }

    /// @notice deposits ether in portal contract and create ether in L2
    /// @param _receivers array with receivers addresses
    /// @param _amounts array of amounts of ether to be distributed
    /// @param _data information to be interpreted by L2
    /// @return hash of input generated by deposit
    /// @dev  receivers[i] receive amounts[i]
    function etherDeposit(
        address[] calldata _receivers,
        uint256[] calldata _amounts,
        bytes calldata _data
    ) external payable returns (bytes32);

    /// @notice deposits ERC20 in portal contract and create tokens in L2
    /// @param _ERC20 address of ERC20 token to be deposited
    /// @param _receivers array with receivers addresses
    /// @param _amounts array of amounts of ether to be distributed
    /// @param _data information to be interpreted by L2
    /// @return hash of input generated by deposit
    /// @dev  receivers[i] receive amounts[i]
    function erc20Deposit(
        address _ERC20,
        address[] calldata _receivers,
        uint256[] calldata _amounts,
        bytes calldata _data
    ) external returns (bytes32);


    /// @notice deposits generic assets
    /// @param _data information to be interpreted by L2
    /// @dev the onchain code doesn't understand any of this
    ///      its up to the offchain code to parse the data
    ///      and guarantee that the deposit was made
    function genericDeposit(bytes calldata _data) external returns (bytes32);

    /// @notice executes a descartesV2 output
    /// @param _data data with information necessary to execute output
    /// @return status of output execution
    /// @dev can only be called by Output contract
    function executeDescartesV2Output(bytes calldata _data) external returns (bool);
}