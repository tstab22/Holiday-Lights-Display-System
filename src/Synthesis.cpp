/** @file Synthesis.cpp
 * @author Henry J Schmale
 * @date January 13, 2015
 * Contains implementations of functions for automatically generating shows
 * based on frequency analysis.
 */

#include "../include/Synthesis.hpp"
#include "../include/HolidayLights.hpp"
#include "../Defaults.hpp"
#include "../SQL_CMDS.hpp"
#include <iostream>
#include <cstdlib>
#include <dirent.h>
#include <errno.h>
#include <sqlite3.h>
#include <ncurses.h>
#include <cdk.h>

#define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))


// =============================================================================
// Synthesis Functions                                                         =
// Functions for visualizing sound                                             =
// @author Henry J Schmale                                                     =
// @date Jan 2015                                                              =
// =============================================================================

// parses a song
syn::ShowData* syn::parseSong(hl::SongData sd, int channels)
{
	return NULL;
}

// =============================================================================
// SHOW EDITOR FUNCTIONS                                                       =
// Implementation of show editor functions                                     =
// =============================================================================

// Show Editor Entry Point
static CDKSCREEN *cdkscreen;
int syn::se::ShowEditor()
{
	WINDOW *screen;

	/* Initialize the Cdk screen.   */
	screen = initscr();
	cdkscreen = initCDKScreen (screen);

	/* Start CDK Colors */
	initCDKColor();

	// Begin shows
	syn::se::SelectShow();

	/* Clean up           */
	destroyCDKScreen (cdkscreen);
	endCDK();
	return 0;
}

// Menu to selectW a song
int syn::se::SelectShow()
{
	CDKFSELECT *fselect;
    fselect = newCDKFselect(cdkscreen, CENTER, CENTER, 20, 72, "Select A Song",
							"\n", WA_NORMAL, WA_DIM, WA_STANDOUT, "</2>", "</0>",
							"</3>", "</4>", true, false);
	drawCDKFselect(fselect, true);
	char *ch = activateCDKFselect(fselect, NULL);
	return 0;
}
