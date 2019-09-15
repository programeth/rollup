/*


                                             FeeSelector
                   ╔════════════════════════════════════════════════════════════╗
                   ║  ┌─────────────┐                                           ║
      feePlanCoin──╬─▶│             │                                           ║
                   ║  │      =      │──┬───────────┐                            ║
          coin─────╬─▶│             │  │           │                            ║
                   ║  └─────────────┘  │           │              ┌────────┐    ║
                   ║                   │           └─────────────▶│        │    ║
                   ║                   │                          │   OR   │────╬───▶ isSelectedOut
     isSelectedIn ─╬─────────────┬─────┼─────────────────────────▶│        │    ║
                   ║             │     │                          └────────┘    ║
                   ║             │     │                                        ║
                   ║             │     │        ┌───────┐                       ║
                   ║             │     └───────▶│       │                       ║
                   ║             │            . │  AND  │──────────┐            ║
                   ║             └──────────▶( )│       │          │            ║
                   ║                          ' └───────┘          │            ║
                   ║                                               │            ║
                   ║                                             ╲ │            ║
    currentFeeIn  ─╬─────────────────────────────────────────────▶╲▼            ║
                   ║                                               ╲            ║
                   ║                                                ────────────╬──▶ currentFeeOut
                   ║                                               ╱            ║
       feePlanFee  ╠─────────────────────────────────────────────▶╱             ║
                   ║                                             ╱              ║
                   ║                                                            ║
                   ╚════════════════════════════════════════════════════════════╝


      feePlanFee[0]  ────┐
      feePlanFee[1]  ────┼──────────┐
      feePlanFee[2]  ────┼──────────┼──────────┐
      feePlanFee[3]  ────┼──────────┼──────────┼──────────┐
      feePlanFee[4]  ────┼──────────┼──────────┼──────────┼──────────┐
      feePlanFee[5]  ────┼──────────┼──────────┼──────────┼──────────┼──────────┐
      feePlanFee[6]  ────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┐
      feePlanFee[7]  ────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┐
      feePlanFee[8]  ────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┐
      feePlanFee[9]  ────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┐
     feePlanFee[10]  ────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┐
     feePlanFee[11]  ────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┐
     feePlanFee[12]  ────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┐
     feePlanFee[13]  ────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┐
     feePlanFee[14]  ────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┐
     feePlanFee[15]  ────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┐
                         │          │          │          │          │          │          │          │          │          │          │          │          │          │          │          │
      feePlanCoin[0] ────┼─┐        │          │          │          │          │          │          │          │          │          │          │          │          │          │          │
      feePlanCoin[1] ────┼─┼────────┼─┐        │          │          │          │          │          │          │          │          │          │          │          │          │          │
      feePlanCoin[2] ────┼─┼────────┼─┼────────┼─┐        │          │          │          │          │          │          │          │          │          │          │          │          │
      feePlanCoin[3] ────┼─┼────────┼─┼────────┼─┼────────┼─┐        │          │          │          │          │          │          │          │          │          │          │          │
      feePlanCoin[4] ────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┐        │          │          │          │          │          │          │          │          │          │          │
      feePlanCoin[5] ────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┐        │          │          │          │          │          │          │          │          │          │
      feePlanCoin[6] ────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┐        │          │          │          │          │          │          │          │          │
      feePlanCoin[7] ────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┐        │          │          │          │          │          │          │          │
      feePlanCoin[8] ────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┐        │          │          │          │          │          │          │
      feePlanCoin[9] ────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┐        │          │          │          │          │          │
     feePlanCoin[10] ────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┐        │          │          │          │          │
     feePlanCoin[11] ────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┐        │          │          │          │
     feePlanCoin[12] ────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┐        │          │          │
     feePlanCoin[13] ────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┐        │          │
     feePlanCoin[14] ────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┐        │
     feePlanCoin[15] ────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┼────────┼─┐
                         │ │        │ │        │ │        │ │        │ │        │ │        │ │        │ │        │ │        │ │        │ │        │ │        │ │        │ │        │ │        │ │
          coin    ─────●─┼─┼──────●─┼─┼──────●─┼─┼──────●─┼─┼──────●─┼─┼──────●─┼─┼──────●─┼─┼──────●─┼─┼──────●─┼─┼──────●─┼─┼──────●─┼─┼──────●─┼─┼──────●─┼─┼──────●─┼─┼──────●─┼─┼──────┐ │ │
                       │ │ │      │ │ │      │ │ │      │ │ │      │ │ │      │ │ │      │ │ │      │ │ │      │ │ │      │ │ │      │ │ │      │ │ │      │ │ │      │ │ │      │ │ │      │ │ │
                       ▼ ▼ ▼      ▼ ▼ ▼      ▼ ▼ ▼      ▼ ▼ ▼      ▼ ▼ ▼      ▼ ▼ ▼      ▼ ▼ ▼      ▼ ▼ ▼      ▼ ▼ ▼      ▼ ▼ ▼      ▼ ▼ ▼      ▼ ▼ ▼      ▼ ▼ ▼      ▼ ▼ ▼      ▼ ▼ ▼      ▼ ▼ ▼
                     ┌───────┐  ┌───────┐  ┌───────┐  ┌───────┐  ┌───────┐  ┌───────┐  ┌───────┐  ┌───────┐  ┌───────┐  ┌───────┐  ┌───────┐  ┌───────┐  ┌───────┐  ┌───────┐  ┌───────┐  ┌───────┐
                0 ──▶│       ├─▶│       ├─▶│       ├─▶│       ├─▶│       ├─▶│       ├─▶│       ├─▶│       │─▶│       ├─▶│       ├─▶│       ├─▶│       ├─▶│       ├─▶│       ├─▶│       ├─▶│       │
                     │stp[0] │  │stp[1] │  │stp[2] │  │stp[3] │  │stp[4] │  │stp[5] │  │stp[6] │  │stp[7] │  │stp[8] │  │stp[9] │  │stp[10]│  │stp[11]│  │stp[12]│  │stp[13]│  │stp[14]│  │stp[15]│
                0 ──▶│       ├─▶│       ├─▶│       ├─▶│       ├─▶│       ├─▶│       ├─▶│       ├─▶│       ├─▶│       ├─▶│       ├─▶│       ├─▶│       ├─▶│       ├─▶│       ├─▶│       ├─▶│       │──▶ fee
                     └───────┘  └───────┘  └───────┘  └───────┘  └───────┘  └───────┘  └───────┘  └───────┘  └───────┘  └───────┘  └───────┘  └───────┘  └───────┘  └───────┘  └───────┘  └───────┘

*/

include "../node_modules/circomlib/circuits/comparators.circom";
include "../node_modules/circomlib/circuits/mux1.circom";
template FeeSelectorStep() {
    signal input coin;
    signal input feePlanCoin;
    signal input isSelectedIn;
    signal input currentFeeIn;
    signal input feePlanFee;
    signal input counterBaseIn;
    signal output isSelectedOut;
    signal output currentFeeOut;
    signal output counterBaseOut;

    component isEqual = IsEqual();
    isEqual.in[0] <== coin;
    isEqual.in[1] <== feePlanCoin;

    signal isSelectedIsEqual;
    isSelectedIsEqual <== isSelectedIn*isEqual.out;

    component mux1 = Mux1();
    mux1.c[0] <== currentFeeIn;
    mux1.c[1] <== feePlanFee;

    // mux1.s <== (1 - isSelectedIn)*isEqual.out
    mux1.s <== isEqual.out - isSelectedIsEqual

    currentFeeOut <== mux1.out;

    isSelectedOut <== isSelectedIn + isEqual.out - isSelectedIsEqual;

    component mux2 = Mux1();
    mux2.c[0] <== counterBaseIn*(1<<16);
    mux2.c[1] <== counterBaseIn;
    mux2.s <== isSelectedOut;
    mux2.out ==> counterBaseOut;

}

template FeeSelector() {
    signal input coin;
    signal input feePlanCoin[16];
    signal input feePlanFee[16];
    signal output operatorsFee;
    signal output countersBase;

    component stp[16];

    for (var i=0;i<16; i++) {
        stp[i] = FeeSelectorStep();
        if (i==0) {
            stp[i].isSelectedIn <== 0;
            stp[i].currentFeeIn <== 0;
            stp[i].counterBaseIn <== 1;
        } else {
            stp[i].isSelectedIn <== stp[i-1].isSelectedOut;
            stp[i].currentFeeIn <== stp[i-1].currentFeeOut;
            stp[i].counterBaseIn <== stp[i-1].counterBaseOut;
        }
        stp[i].coin <== coin;
        stp[i].feePlanCoin <== feePlanCoin[i];
        stp[i].feePlanFee <== feePlanFee[i];
    }

    operatorsFee <== stp[15].currentFeeOut;
    countersBase <== stp[15].counterBaseOut * stp[15].isSelectedOut;
}