# RISC-V Multi-Cycle Processor (Verilog)

A 32-bit RISC-V (RV32I subset) multi-cycle processor in Verilog, simulated in Xilinx Vivado 2018. Each instruction is split across several shorter clock cycles and controlled by a finite state machine, so hardware such as the ALU and a single unified memory is reused across steps.

## Supported instructions
| Type | Instructions |
|---|---|
| R-type | `add`, `sub`, `and`, `or` |
| I-type ALU | `addi` and related immediate ops |
| Load / Store | `lw`, `sw` |
| Branch | `beq` |
| Jump | `jal` |

## Control FSM
```
Fetch → Decode ─┬─ MemAdr ─┬─ MemRead → MemWB ──→ Fetch   (lw)
                │          └─ MemWrite ─────────→ Fetch   (sw)
                ├─ ExecuteR → ALUWB ────────────→ Fetch   (R-type)
                ├─ ExecuteI → ALUWB ────────────→ Fetch   (I-type)
                ├─ JAL → ALUWB ─────────────────→ Fetch
                └─ BEQ ─────────────────────────→ Fetch
```
Implemented in `control_unit.v` (FSM + ALU decoder + extender decoder).

## Architecture
- **Unified instruction/data memory**: `Inst_DM.v`
- **Non-architectural registers** between steps: `Instr.v` (instruction register), `Data.v` (memory data register), `RF_Reg.v` (A/B register-file outputs), `ALU_Reg.v` (ALUOut)
- **Register file**: `REG_FILE.v`
- **Immediate generator**: `Imm_Gen.v`
- **ALU**: `ALU.v`
- **Muxes**: `mux_2x1.v` (2:1 and 3:1)
- **Top level**: `top_module.v`

## Repository structure
```
rtl/    Verilog design sources
tb/     Unit testbenches + top-level testbench (tb_top_module.v)
docs/   Full report: FSM design, datapath analysis, simulation verification
```

## How to simulate
1. Add everything in `rtl/` to a Vivado project as design sources.
2. Add `tb/tb_top_module.v` as the simulation top.
3. Run behavioral simulation and step through the FSM states for each instruction.

## Report
See [`docs/Multi_Cycle_Report.pdf`](docs/Multi_Cycle_Report.pdf).

---
Built as part of the Computer Architecture module, Chip Design & Verification program, GIKI.
Reference: Harris & Harris, *Digital Design and Computer Architecture: RISC-V Edition*.
