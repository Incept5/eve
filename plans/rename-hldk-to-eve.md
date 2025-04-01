<!-- Agent Note: Mark each section as complete by changing [ ] to [x] -->

# Plan: Rename hldk/HigherLevelDevKit to eve/Eve

**Goal:** Rename all occurrences of `hldk` and `HigherLevelDevKit` (case-insensitive) to `eve` and `Eve` respectively throughout the project codebase, configuration, documentation, and assets.

## 1. File Renames [x]

The following files need to be renamed:

-   `hldk.sh` -> `eve.sh`
-   `chromaAndHldk.sh` -> `chromaAndEve.sh`
-   `win-hldk.bat` -> `win-eve.bat`
-   `assets/hldk-*.png` -> `assets/eve-*.png` (Verify if `eve-*.png` equivalents already exist, otherwise rename)
-   `server/webui/hldk_*.png` -> `server/webui/eve_*.png` (Verify if `eve_*.png` equivalents already exist, otherwise rename)

*Note: `server/hldk-server.js` seems to have already been renamed to `server/eve-server.js` based on the initial file listing.*

## 2. Directory Renames [x]

The following directories need to be renamed:

-   `.hldk` -> `.eve`

## 3. Content Updates [x]

Update occurrences of `hldk`, `HLDK`, and `HigherLevelDevKit` (case-insensitive) to `eve`, `Eve`, and `Eve` respectively within the following files:

-   **Scripts:**
    -   `eve.sh` (previously `hldk.sh`): Update internal references (e.g., `HLDK Server`, `hldk-server.js` -> `eve-server.js`, `HLDK server`).
    -   `chromaAndEve.sh` (previously `chromaAndHldk.sh`): Update internal references (e.g., `HLDK`, `./hldk.sh` -> `./eve.sh`).
    -   `win-eve.bat` (previously `win-hldk.bat`): Update internal references (e.g., `HLDK Server`, `hldk-server.js` -> `eve-server.js`).
    -   `docker/up.sh`: Update service checks (e.g., `hldk.*`, `HLDK`).

-   **Configuration:**
    -   `.env.example`: Update commented path (`# HLDK_DB_PATH` -> `# EVE_DB_PATH`).
    -   `.gitignore`: Update ignored path (`hldk-server/data` -> `eve-server/data` - *confirm if this path is still relevant*).
    -   `Dockerfile`: Update `CMD` instruction (`./hldk.sh` -> `./eve.sh`).
    -   `docker/docker-compose.yml`: Update service name (`hldk` -> `eve`), volume name (`hldk_data` -> `eve_data`), and any other references.

-   **Source Code:**
    -   Note: Files under `/server` are generated in another project and do not need renaming.

-   **Documentation:**
    -   `README.md`: Update all mentions of `Higher Level Dev Kit (HLDK)`, `HLDK`, `hldk.sh`, `higherlevel.dev/app`, `hldk-server`, `~/.hldk/mcp-servers`, `hldk`, `HigherLevelDevKit`, `chromaAndHldk.sh`, and update image paths (`assets/hldk-*.png` -> `assets/eve-*.png`).
    -   `guide/index.md`: Update mentions of `HLDK`, `.hldkignore` -> `.eveignore`.
    -   `docker/README.md`: Update mentions of `HigherLevelDevKit`, `hldk`, `hldk_chroma_data` -> `eve_chroma_data`.

-   **Internal Spec Files:**
    -   Files within `.eve/specs/` (previously `.hldk/specs/`): Update references like `hldk.sh`, `HLDK`, `hldk`, `higherleveldev/hldk`.

## 4. Asset Updates [ ]

-   Review `assets/` and `server/webui/` directories.
-   Update references in `README.md` and potentially other UI files to point to `eve_*` assets (e.g., `eve_logo.png`, `eve_glyph.png`).
-   Rename any remaining `hldk-*` assets to `eve-*` if corresponding `eve-*` assets do not already exist.

## 5. Verification Steps [ ]

After applying all changes:

1.  Run the renamed scripts (`eve.sh`, `chromaAndEve.sh`, `win-eve.bat`) to ensure they execute correctly.
2.  Run `docker compose up` using the updated `docker-compose.yml` and verify the `eve` service starts and functions.
3.  Access the web UI and check for correct branding, text, and image display.
4.  Review `README.md` and other documentation files for accuracy and broken links/images.
5.  Perform a global search for `hldk` and `HigherLevelDevKit` (case-insensitive) to catch any missed occurrences.
