// An entry point offset that indicates that nothing needs to be done.
// Used to implement an empty constructor.
const NOP_ENTRY_POINT_OFFSET = -1;

const ENTRY_POINT_TYPE_EXTERNAL = 0;
const ENTRY_POINT_TYPE_L1_HANDLER = 1;
const ENTRY_POINT_TYPE_CONSTRUCTOR = 2;

const L1_HANDLER_VERSION = 0;

const SIERRA_ARRAY_LEN_BOUND = 2 ** 32;

// get_selector_from_name('constructor').
const CONSTRUCTOR_ENTRY_POINT_SELECTOR = (
    0x28ffe4ff0f226a9107253e17a904099aa4f63a02a5621de0576e5aa71bc5194
);

// get_selector_from_name('__execute__').
const EXECUTE_ENTRY_POINT_SELECTOR = (
    0x15d40a3d6ca2ac30f4031e42be28da9b056fef9bb7357ac5e85627ee876e5ad
);

// get_selector_from_name('__validate__').
const VALIDATE_ENTRY_POINT_SELECTOR = (
    0x162da33a4585851fe8d3af3c2a9c60b557814e221e0d4f30ff0b2189d9c7775
);

// get_selector_from_name('__validate_declare__').
const VALIDATE_DECLARE_ENTRY_POINT_SELECTOR = (
    0x289da278a8dc833409cabfdad1581e8e7d40e42dcaed693fa4008dcdb4963b3
);

// get_selector_from_name('__validate_deploy__').
const VALIDATE_DEPLOY_ENTRY_POINT_SELECTOR = (
    0x36fcbf06cd96843058359e1a75928beacfac10727dab22a3972f0af8aa92895
);

// get_selector_from_name('transfer').
const TRANSFER_ENTRY_POINT_SELECTOR = (
    0x83afd3f4caedc6eebf44246fe54e38c95e3179a5ec9ea81740eca5b482d12e
);

const DEFAULT_ENTRY_POINT_SELECTOR = 0;

// OS reserved contract addresses.

// This contract stores the block number -> block hash mapping.
const BLOCK_HASH_CONTRACT_ADDRESS = 1;
// The block number -> block hash mapping is written for the current block number minus this number.
const STORED_BLOCK_HASH_BUFFER = 10;

// Gas constants.
const STEP_GAS_COST = 100;
const RANGE_CHECK_GAS_COST = 70;
const MEMORY_HOLE_GAS_COST = 10;

const INITIAL_GAS_COST = (10 ** 8) * STEP_GAS_COST;

// Compiler gas costs.

// The initial budget at an entry point. This needs to be high enough to cover the initial get_gas.
// The entry point may refund whatever remains from the initial budget.
const ENTRY_POINT_INITIAL_BUDGET = 100 * STEP_GAS_COST;
// The gas cost of each syscall libfunc (this value is hard-coded by the compiler).
// This needs to be high enough to cover OS costs in the case of failure due to out of gas.
const SYSCALL_BASE_GAS_COST = 100 * STEP_GAS_COST;

// OS gas costs.

// The base amount of gas for executing an entry point. This amount is reduced from the gas
// counter by the OS. The rest of the required gas will be taken from the gas counter by the
// contract.
const ENTRY_POINT_GAS_COST = ENTRY_POINT_INITIAL_BUDGET + 500 * STEP_GAS_COST;

const FEE_TRANSFER_GAS_COST = ENTRY_POINT_GAS_COST + 100 * STEP_GAS_COST;
// The base amount of gas for executing a transaction. For example, this includes the cost of the
// fee transfer and execution of two entry points ('validate' and 'execute').
const TRANSACTION_GAS_COST = (2 * ENTRY_POINT_GAS_COST) + FEE_TRANSFER_GAS_COST + (
    100 * STEP_GAS_COST
);
// Syscall gas costs.
const CALL_CONTRACT_GAS_COST = SYSCALL_BASE_GAS_COST + 10 * STEP_GAS_COST + ENTRY_POINT_GAS_COST;
const DEPLOY_GAS_COST = SYSCALL_BASE_GAS_COST + 200 * STEP_GAS_COST + ENTRY_POINT_GAS_COST;
const GET_BLOCK_HASH_GAS_COST = SYSCALL_BASE_GAS_COST + 50 * STEP_GAS_COST;
const GET_EXECUTION_INFO_GAS_COST = SYSCALL_BASE_GAS_COST + 10 * STEP_GAS_COST;
const LIBRARY_CALL_GAS_COST = CALL_CONTRACT_GAS_COST;
const REPLACE_CLASS_GAS_COST = SYSCALL_BASE_GAS_COST + 50 * STEP_GAS_COST;
const STORAGE_READ_GAS_COST = SYSCALL_BASE_GAS_COST + 50 * STEP_GAS_COST;
const STORAGE_WRITE_GAS_COST = SYSCALL_BASE_GAS_COST + 50 * STEP_GAS_COST;
const EMIT_EVENT_GAS_COST = SYSCALL_BASE_GAS_COST + 10 * STEP_GAS_COST;
const SEND_MESSAGE_TO_L1_GAS_COST = SYSCALL_BASE_GAS_COST + 50 * STEP_GAS_COST;

// Note the the following costs include `SYSCALL_BASE_GAS_COST` implicitly.
const SECP256K1_ADD_GAS_COST = 406 * STEP_GAS_COST + 29 * RANGE_CHECK_GAS_COST;
const SECP256K1_GET_POINT_FROM_X_GAS_COST = 391 * STEP_GAS_COST + 30 * RANGE_CHECK_GAS_COST + 20 *
    MEMORY_HOLE_GAS_COST;
const SECP256K1_GET_XY_GAS_COST = 239 * STEP_GAS_COST + 11 * RANGE_CHECK_GAS_COST + 40 *
    MEMORY_HOLE_GAS_COST;
const SECP256K1_MUL_GAS_COST = 121956 * STEP_GAS_COST + 10739 * RANGE_CHECK_GAS_COST;
const SECP256K1_NEW_GAS_COST = 475 * STEP_GAS_COST + 35 * RANGE_CHECK_GAS_COST + 40 *
    MEMORY_HOLE_GAS_COST;
const SECP256R1_ADD_GAS_COST = 589 * STEP_GAS_COST + 57 * RANGE_CHECK_GAS_COST;
const SECP256R1_GET_POINT_FROM_X_GAS_COST = 510 * STEP_GAS_COST + 44 * RANGE_CHECK_GAS_COST + 20 *
    MEMORY_HOLE_GAS_COST;
const SECP256R1_GET_XY_GAS_COST = 241 * STEP_GAS_COST + 11 * RANGE_CHECK_GAS_COST + 40 *
    MEMORY_HOLE_GAS_COST;
const SECP256R1_MUL_GAS_COST = 195595 * STEP_GAS_COST + 21477 * RANGE_CHECK_GAS_COST;
const SECP256R1_NEW_GAS_COST = 594 * STEP_GAS_COST + 49 * RANGE_CHECK_GAS_COST + 40 *
    MEMORY_HOLE_GAS_COST;

const KECCAK_GAS_COST = SYSCALL_BASE_GAS_COST;
const KECCAK_ROUND_COST_GAS_COST = 180000;

// Cairo 1.0 error codes.
const ERROR_BLOCK_NUMBER_OUT_OF_RANGE = 'Block number out of range';
const ERROR_OUT_OF_GAS = 'Out of gas';
const ERROR_INVALID_INPUT_LEN = 'Invalid input length';
const ERROR_INVALID_ARGUMENT = 'Invalid argument';

// The expected return value of the `__validate*__` functions of a Cairo 1.0 account contract.
const VALIDATED = 'VALID';

// Resources
const L1_GAS = 'L1_GAS';
const L2_GAS = 'L2_GAS';
const L1_GAS_INDEX = 0;
const L2_GAS_INDEX = 1;
