# Useage

    docker run -p 8000:8000 -d bluespice/parsoid:REL1_31

# MediaWiki LocalSettings config
Install instruction for VisualEditor can be found here: https://www.mediawiki.org/wiki/Extension:VisualEditor

This is a auto-configuration-setup of parsoid. There is no need to configure the calling MediaWiki instance with parsoid. Instead you will need to pass the wikis API endpoint url as a Base64 encoded string within the `domain` field.

Example:

    $fullPath = $GLOBALS['wgServer'] . $GLOBALS['wgScriptPath'];
    $encFullPath = base64_encode( $fullPath );
    $wgVirtualRestConfig['modules']['parsoid'] = [
	'url' => 'http://<parsoidcontainername>:8000',
	'domain' => $encFullPath,
	'forwardCookies' => true
    ];
    unset( $fullPath );
    unset( $encFullPath );
