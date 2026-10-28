# dh_asset_gate

**One capability bit from GBT V8, packaged standalone.** No. 27 of 341,
`creation` domain (Creation).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> 数字人资产八条闸（**纯读免门 · 一条命令验完**）：① 单网格单蒙皮 ② 没有 42 顶点杂物球 ③ 身高 1.720±0.02（**在文件空间量 POSITION 的 Y 跨度**，不在 Blender 的 Z 里量）④ 无死顶点 ⑤ 髋骨没被扭（<0.5°）⑥ 手臂垂放（40°~120°）⑦ 循环闭合（首末帧差 <2°，含阈值翻正留痕）⑧ 派生件 .b64.js 与源 sha 对账。op=status/run/where

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-dh-asset-gate.git
cd gbt-dh-asset-gate
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_dh_asset_gate info                  # capability card
python -m gbt_dh_asset_gate spec --json           # machine-readable contract
python -m gbt_dh_asset_gate check --payload '{}'
python -m gbt_dh_asset_gate run   --payload '{}'
```

Real `info` output from this machine:

```text
dh_asset_gate  (creation)  v1.0.0
----------------------------------------
数字人资产八条闸（**纯读免门 · 一条命令验完**）：① 单网格单蒙皮 ② 没有 42 顶点杂物球 ③ 身高 1.720±0.02（**在文件空间量 POSITION 的 Y 跨度**，不在 Blender 的 Z 里量）④ 无死顶点 ⑤ 髋骨没被扭（<0.5°）⑥ 手臂垂放（40°~120°）⑦ 循环闭合（首末帧差 <2°，含阈值翻正留痕）⑧ 派生件 .b64.js 与源 sha 对账。op=status/run/where

gated      : False
external   : False
multi-op   : True
params     : (none)
values     : status, run, where
```

Wire a real implementation:

```python
from gbt_dh_asset_gate import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

**注册表登记的取值 / 子动作（3 个）**：`status`、`run`、`where`

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Not gated: the registry marks this bit `safe: true`.
- No external service dependency declared.
- Multi-op (`multi_op: true`): several sub-actions share one name — read `op` before calling.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.14s
```

## Provenance

| field | value |
|---|---|
| capability | `dh_asset_gate` |
| domain | `creation` |
| handler | `dh_rig` |
| safe | `True` (gated = `False`) |
| external | `False` |
| atlas page | [creation/dh_asset_gate](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/creation/dh_asset_gate.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
