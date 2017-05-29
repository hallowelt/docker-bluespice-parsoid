# docker-bluespice-parsoid

## MediaWiki LocalSettings config

'''
wfLoadExtension( 'VisualEditor' );

$wgSessionsInObjectCache = true;
// Enable by default for everybody
$wgDefaultUserOptions['visualeditor-enable'] = 1;

// Optional: Set VisualEditor as the default for anonymous users
// otherwise they will have to switch to VE
// $wgDefaultUserOptions['visualeditor-editor'] = "visualeditor";

// Don't allow users to disable it
$wgHiddenPrefs[] = 'visualeditor-enable';

// OPTIONAL: Enable VisualEditor's experimental code features
#$wgDefaultUserOptions['visualeditor-enable-experimental'] = 1;

$wgVirtualRestConfig['modules']['parsoid'] = array(
	// URL to the Parsoid instance
	// Use port 8142 if you use the Debian package
	'url' => 'http://localhost:8000',
	// Parsoid "domain", see below (optional)
	'domain' => 'localhost',
	// Parsoid "prefix", see below (optional)
	//'prefix' => 'localhost'
	'forwardCookies' => true
);
'''

## Run parsoid docker
'''
git clone https://github.com/hallowelt/docker-bluespice-parsoid.git
cd docker-bluespice-parsoid
docker build -t parsoid .
docker run -d -v ~/path/to/docker-bluespice-parsoid:/opt/parsoid/config -p=8000:8000 parsoid
'''
