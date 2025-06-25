import sys
import urllib.request
from urllib.parse import urljoin
from pathlib import Path
from logger import logger
import yaml


if __name__ == "__main__":
    if len(sys.argv) < 2:
        logger.error(f"Usage: {sys.argv[0]} file.yaml")
        sys.exit(1)

    fnam = Path(sys.argv[1])

    if not fnam.exists():
        logger.error(f"file {fnam} not found")
        sys.exit(1)

    with open(fnam) as inf:
        D = yaml.safe_load(inf)

    base = D["url"]
    builddir = Path(D["builddir"]).expanduser()

    if not builddir.exists():
        logger.error(f"Build dir {builddir} not found")
        sys.exit(1)

    # Define pathdir and create if it does not exist
    patchdir = Path(builddir, "patches")
    if not patchdir.exists():
        patchdir.mkdir()
        logger.info(f"Created directory {patchdir}")

    # Download the patches if needed
    for key, val in D["patches"].items():
        patch = val["patch"]
        pri = val["priority"]
        # If there's a url for this patch, use it
        thebase = val.get("url") or base
        if pri < 0:
            continue
        url = urljoin(thebase, f"{key}/{patch}")
        patchname = f"{pri:03d}-{patch}"
        patchpath = Path(patchdir, patchname)
        if not patchpath.exists():
            urllib.request.urlretrieve(url, patchpath)
            logger.info(f"Downloaded patch: {patch}")

    # Create the list of all patches
    series = []
    for f in patchdir.iterdir():
        fnam = f.relative_to(patchdir)
        if fnam.suffix == ".diff":
            series.append(str(fnam))
    series.sort()

    # Create the patches/series file
    with open(Path(patchdir, "series"), "w") as outf:
        for f in series:
            logger.info(f"Adding patch {f} to series")
            print(f, file=outf)
