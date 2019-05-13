'use strict';

exports.setup = function(parsoidConfig) {
	parsoidConfig.dynamicConfig = function(domain) {
		var baseUrl = Buffer.from( domain, 'base64').toString();
		parsoidConfig.setMwApi({
			uri: baseUrl + '/api.php',
			domain: domain,
			strictSSL: false
		});
	}
};
