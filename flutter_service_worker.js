'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "a875efc6985b42090761061d4796fcc2",
"version.json": "355e0812fd2eb825af090bbe1826daf1",
"index.html": "f87145f99efe06f4f523bdf7ce4a8071",
"/": "f87145f99efe06f4f523bdf7ce4a8071",
"main.dart.js": "a5ee1bfb65084c37dae6ac25d2f7a305",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"favicon.png": "74e09818219e6f4ba8f2856be90d07d2",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "50877bad7c3c19200c5cd04d8e708ae3",
"assets/AssetManifest.json": "9998810389256da6a04ebe3ce05c2c20",
"assets/NOTICES": "9b4ca43993d928129f9a124b8e506117",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "3fbe56480faa453c53bc6d975f7a3d84",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/timezone/data/latest_all.tzf": "df0e82dd729bbaca78b2aa3fd4efd50d",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "ec43f6d45a980c06cb844ed7264be93b",
"assets/fonts/MaterialIcons-Regular.otf": "1db41cbffcac34760464bfe7b358f332",
"assets/assets/images/dots_hori.svg": "ce862eada4980968b52d83a124248781",
"assets/assets/images/profilePicture.png": "7f3fda474d58f232d2ed3940dc25cde8",
"assets/assets/images/play_image.svg": "a16b6bc1a46dc4ec2632146230a87496",
"assets/assets/images/auth_image.png": "c662060eefc42a1ba33b70e4b9232e6f",
"assets/assets/images/avatar.png": "5cdad6ac2b0ce5ca0bb83be4bb16d014",
"assets/assets/images/logo.png": "74e09818219e6f4ba8f2856be90d07d2",
"assets/assets/images/avatar3.png": "1e57f8fbcd3915c308a0b1b54cd87ce1",
"assets/assets/images/avatar1.png": "078c5f367b06efd4423b50404fcee370",
"assets/assets/images/dots_ver.svg": "b9c46818975907f4d6ec9ac12168c68d",
"assets/assets/icons/search.svg": "2cec2d7492e7326d56c7e68a5e173124",
"assets/assets/icons/dots.svg": "3af3cb6482a248d9b6c51910f179ca8c",
"assets/assets/icons/user.svg": "be3aecb17d275de8d4de80c407cc57a1",
"assets/assets/icons/logout.svg": "5a66b5cf72d9a4b78392285f771d7e7c",
"assets/assets/icons/lock.svg": "884b1ba4f86e9871bf469be2e9d3fc1e",
"assets/assets/icons/calender.svg": "ec0570b5eaffee523c946aa51680a2ca",
"assets/assets/icons/clipboard.svg": "4a42241b859172adb346b28b8de6c9eb",
"assets/assets/icons/mail.svg": "592c6aa9f5fedd2f92ac32977931efd9",
"assets/assets/icons/gallery.svg": "65098a843c74994d00255d2e8bf30555",
"assets/assets/icons/dashboard.svg": "e205bd84bec886410fa05426c7a1030d",
"assets/assets/icons/subscription.svg": "e790c751b6d4a112d751196be4693075",
"assets/assets/icons/setting.svg": "167ae31323a42d40eecf0e1795eedfd5",
"assets/assets/icons/pdf.svg": "04ad834a750f7606e34c80900a23157a",
"assets/assets/icons/filter.svg": "308bd5e6606b66705d2572967c23c294",
"assets/assets/icons/calendar.svg": "c37c7a373190d6ddd4d89d333b004de3",
"assets/assets/icons/upload.svg": "6932d1322282b92507ee07fef49ce294",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
