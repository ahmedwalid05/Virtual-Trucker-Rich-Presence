// VIRTUAL TRUCKER RICH PRESENCE

const packageInfo = require('./package.json');

module.exports = {
    applications: {
        // ets2: '432559364772200479',
        ets2: '755285851377893480',
        ats: '755285851377893480',
    },
    version: `Laggy Logistics Rich Presence ${packageInfo.version}`,
    kmToMilesConversion: 0.62,
    mpCheckerIntervalMilliseconds: 5 * 60 * 1000,
    locationCheckerIntervalMilliseconds: 2.5 * 60 * 1000,
    kmString: 'KM',
    milesString: 'Mi',
    kphString: 'km/h',
    mphString: 'mph',
    constants: {
        km: 'km',
        miles: 'm',
        ets2: 'ets2',
        ats: 'ats',
        brandPrefix: 'brand_',
        brandGenericKey: 'brand_generic',
        ets2LargeImagePrefix: 'ets2rpc_',
        atsLargeImagePrefix: 'atsrpc_',
        promodsLargeImagePrefix: 'promods_',
        largeImageKeys: {
            idle: 'idle',
            active: 'active',
        },
        speedMultiplierValue: 3.6
    },
    supportedBrands: [
        'daf',
        'freightliner',
        'international',
        'intnational',
        'iveco',
        'kamaz',
        'kenworth',
        'mack',
        'man',
        'mercedes',
        'peterbilt',
        'renault',
        'scania',
        'skoda',
        'volvo',
        'tesla'
    ],
    latestReleaseAPIUrl: 'https://api.github.com/repos/ahmedwalid05/Virtual-Trucker-Rich-Presence/releases/latest',
    latestReleasePage: 'https://github.com/ahmedwalid05/Virtual-Trucker-Rich-Presence/releases/latest'
}