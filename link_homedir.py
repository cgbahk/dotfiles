from pathlib import Path

source_home_dir = Path(__file__).parent / "homedir"
assert source_home_dir.is_dir()


def main():
    for source_path in source_home_dir.rglob("*"):
        if source_path.is_dir():
            continue

        relative_path = source_path.relative_to(source_home_dir)
        target_path = Path.home() / relative_path

        if target_path.exists():
            assert target_path.is_symlink()
            assert target_path.resolve() == source_path.resolve()
            print(f"{relative_path}\t: Already exists")
            continue

        target_path.parent.mkdir(parents=True, exist_ok=True)
        target_path.symlink_to(source_path)
        print(f"{relative_path}\t: Newly linked")


if __name__ == "__main__":
    main()
