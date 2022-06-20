{src, composerEnv, fetchurl, fetchgit ? null, fetchhg ? null, fetchsvn ? null, noDev ? false}:

let
  packages = {
    "ademarre/binary-to-text-php" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "ademarre-binary-to-text-php-5d98d17be16d65e03851654a717293a4317bb947";
        src = fetchurl {
          url = "https://api.github.com/repos/ademarre/binary-to-text-php/zipball/5d98d17be16d65e03851654a717293a4317bb947";
          sha256 = "0mdk7dg691drbfv8g8a0b6xbrhfpddm1g65lwgwby03wxnbi4x90";
        };
      };
    };
    "defuse/php-encryption" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "defuse-php-encryption-77880488b9954b7884c25555c2a0ea9e7053f9d2";
        src = fetchurl {
          url = "https://api.github.com/repos/defuse/php-encryption/zipball/77880488b9954b7884c25555c2a0ea9e7053f9d2";
          sha256 = "1lcvpg56nw72cxyh6sga7fx94qw9l0l1y78z7y7ny3hgdniwhihx";
        };
      };
    };
    "doctrine/annotations" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-annotations-5b668aef16090008790395c02c893b1ba13f7e08";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/annotations/zipball/5b668aef16090008790395c02c893b1ba13f7e08";
          sha256 = "129dixpipqfi55yq1rcp7dwj1yl1w70i462rs16ma4bn5vzxqz5s";
        };
      };
    };
    "doctrine/cache" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-cache-56cd022adb5514472cb144c087393c1821911d09";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/cache/zipball/56cd022adb5514472cb144c087393c1821911d09";
          sha256 = "1ri5pwrnq8pxjv8ljscvlaqzjj7ii87420af4dq133qm35jn4ffr";
        };
      };
    };
    "doctrine/collections" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-collections-1958a744696c6bb3bb0d28db2611dc11610e78af";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/collections/zipball/1958a744696c6bb3bb0d28db2611dc11610e78af";
          sha256 = "0ygsw2vgrkz1wd9aw6gd8y6kjwxq9bjqcp3dgdx0p8w9mz7bdpm5";
        };
      };
    };
    "doctrine/common" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-common-f3812c026e557892c34ef37f6ab808a6b567da7f";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/common/zipball/f3812c026e557892c34ef37f6ab808a6b567da7f";
          sha256 = "16jf1wzs6ccpw2ny7rkzpf0asdwr1cfzcyw8g5x88i4j9jazn8xa";
        };
      };
    };
    "doctrine/event-manager" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-event-manager-41370af6a30faa9dc0368c4a6814d596e81aba7f";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/event-manager/zipball/41370af6a30faa9dc0368c4a6814d596e81aba7f";
          sha256 = "0pn2aiwl4fvv6fcwar9alng2yrqy8bzc58n4bkp6y2jnpw5gp4m8";
        };
      };
    };
    "doctrine/inflector" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-inflector-4bd5c1cdfcd00e9e2d8c484f79150f67e5d355d9";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/inflector/zipball/4bd5c1cdfcd00e9e2d8c484f79150f67e5d355d9";
          sha256 = "0390gkbk3vdjd98h7wjpdv0579swbavrdb6yrlslfdr068g4bmbf";
        };
      };
    };
    "doctrine/lexer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-lexer-c268e882d4dbdd85e36e4ad69e02dc284f89d229";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/lexer/zipball/c268e882d4dbdd85e36e4ad69e02dc284f89d229";
          sha256 = "12g069nljl3alyk15884nd1jc4mxk87isqsmfj7x6j2vxvk9qchs";
        };
      };
    };
    "doctrine/persistence" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-persistence-7a6eac9fb6f61bba91328f15aa7547f4806ca288";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/persistence/zipball/7a6eac9fb6f61bba91328f15aa7547f4806ca288";
          sha256 = "0mszkf7lxdhbr5b3ibpn7ipyrf6a6kfj283fvh83akyv1mplsl0h";
        };
      };
    };
    "doctrine/reflection" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-reflection-1034e5e71f89978b80f9c1570e7226f6c3b9b6fb";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/reflection/zipball/1034e5e71f89978b80f9c1570e7226f6c3b9b6fb";
          sha256 = "08n0m6z8b66b0v8awl1w8s8ncg61sa25273ba42fbjmn24b3h6mp";
        };
      };
    };
    "guzzlehttp/guzzle" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "guzzlehttp-guzzle-724562fa861e21a4071c652c8a159934e4f05592";
        src = fetchurl {
          url = "https://api.github.com/repos/guzzle/guzzle/zipball/724562fa861e21a4071c652c8a159934e4f05592";
          sha256 = "1jmwz5zc0xrwlwfz8p313k8wmcwgjk6xz8ngcnv7k6hbrc77lvnv";
        };
      };
    };
    "guzzlehttp/promises" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "guzzlehttp-promises-fe752aedc9fd8fcca3fe7ad05d419d32998a06da";
        src = fetchurl {
          url = "https://api.github.com/repos/guzzle/promises/zipball/fe752aedc9fd8fcca3fe7ad05d419d32998a06da";
          sha256 = "09ivi77y49bpc2sy3xhvgq22rfh2fhv921mn8402dv0a8bdprf56";
        };
      };
    };
    "guzzlehttp/psr7" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "guzzlehttp-psr7-337e3ad8e5716c15f9657bd214d16cc5e69df268";
        src = fetchurl {
          url = "https://api.github.com/repos/guzzle/psr7/zipball/337e3ad8e5716c15f9657bd214d16cc5e69df268";
          sha256 = "0qpldw2aw55dm275hgavw9h53l5697ahiz7cn2d0fz97l8j7fg9p";
        };
      };
    };
    "klein/klein" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "klein-klein-6549676cc831b9417332b3d9485c64bbf7bac728";
        src = fetchurl {
          url = "https://api.github.com/repos/klein/klein.php/zipball/6549676cc831b9417332b3d9485c64bbf7bac728";
          sha256 = "16lxj19d3z5pj1v0x6fc6gi8byzdqvgab49ak68ajc6j6sfs4pml";
        };
      };
    };
    "laravel/serializable-closure" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "laravel-serializable-closure-09f0e9fb61829f628205b7c94906c28740ff9540";
        src = fetchurl {
          url = "https://api.github.com/repos/laravel/serializable-closure/zipball/09f0e9fb61829f628205b7c94906c28740ff9540";
          sha256 = "1b0kdx0cs43ci4pyhhv874k5i0k42iiizz1mz0f6wk8lpzhk0r6r";
        };
      };
    };
    "monolog/monolog" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "monolog-monolog-904713c5929655dc9b97288b69cfeedad610c9a1";
        src = fetchurl {
          url = "https://api.github.com/repos/Seldaek/monolog/zipball/904713c5929655dc9b97288b69cfeedad610c9a1";
          sha256 = "17fjd5dk45b6dbfx15vxqk6mnm3fsn2kd8nsjfjd2zk3zfihq4jj";
        };
      };
    };
    "paragonie/random_compat" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "paragonie-random_compat-996434e5492cb4c3edcb9168db6fbb1359ef965a";
        src = fetchurl {
          url = "https://api.github.com/repos/paragonie/random_compat/zipball/996434e5492cb4c3edcb9168db6fbb1359ef965a";
          sha256 = "0ky7lal59dihf969r1k3pb96ql8zzdc5062jdbg69j6rj0scgkyx";
        };
      };
    };
    "php-di/invoker" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "php-di-invoker-cd6d9f267d1a3474bdddf1be1da079f01b942786";
        src = fetchurl {
          url = "https://api.github.com/repos/PHP-DI/Invoker/zipball/cd6d9f267d1a3474bdddf1be1da079f01b942786";
          sha256 = "08x7h3lyx9dds6wd6v97lzvrn8frqqca6gwhjnc1rd29rms5r34s";
        };
      };
    };
    "php-di/php-di" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "php-di-php-di-ae0f1b3b03d8b29dff81747063cbfd6276246cc4";
        src = fetchurl {
          url = "https://api.github.com/repos/PHP-DI/PHP-DI/zipball/ae0f1b3b03d8b29dff81747063cbfd6276246cc4";
          sha256 = "16x9mbizymv8fc7cws0n7mdgfp1xzh43nd50bh1d0pjavzf1yxlr";
        };
      };
    };
    "php-di/phpdoc-reader" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "php-di-phpdoc-reader-66daff34cbd2627740ffec9469ffbac9f8c8185c";
        src = fetchurl {
          url = "https://api.github.com/repos/PHP-DI/PhpDocReader/zipball/66daff34cbd2627740ffec9469ffbac9f8c8185c";
          sha256 = "07mz3rpcsjn29jdq88id9zcg0g55gsi7g58pbf411kgz9qv9y0sa";
        };
      };
    };
    "phpmailer/phpmailer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpmailer-phpmailer-b52ed06864fdda81b82ec8bf564cf15d45ed4f95";
        src = fetchurl {
          url = "https://api.github.com/repos/PHPMailer/PHPMailer/zipball/b52ed06864fdda81b82ec8bf564cf15d45ed4f95";
          sha256 = "0m5nzx58j635zx6y4c0rcil75y2dx09kxfg1sgfwnxv9p8inry3a";
        };
      };
    };
    "phpseclib/phpseclib" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpseclib-phpseclib-c812fbb4d6b4d7f30235ab7298a12f09ba13b37c";
        src = fetchurl {
          url = "https://api.github.com/repos/phpseclib/phpseclib/zipball/c812fbb4d6b4d7f30235ab7298a12f09ba13b37c";
          sha256 = "0yak18zyyjhqd2l5mlgiinw9rf4rrvbyxp2fnivjvm93jymhhl49";
        };
      };
    };
    "psr/cache" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-cache-d11b50ad223250cf17b86e38383413f5a6764bf8";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/cache/zipball/d11b50ad223250cf17b86e38383413f5a6764bf8";
          sha256 = "06i2k3dx3b4lgn9a4v1dlgv8l9wcl4kl7vzhh63lbji0q96hv8qz";
        };
      };
    };
    "psr/container" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-container-513e0666f7216c7459170d56df27dfcefe1689ea";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/container/zipball/513e0666f7216c7459170d56df27dfcefe1689ea";
          sha256 = "00yvj3b5ls2l1d0sk38g065raw837rw65dx1sicggjnkr85vmfzz";
        };
      };
    };
    "psr/http-message" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-http-message-f6561bf28d520154e4b0ec72be95418abe6d9363";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/http-message/zipball/f6561bf28d520154e4b0ec72be95418abe6d9363";
          sha256 = "195dd67hva9bmr52iadr4kyp2gw2f5l51lplfiay2pv6l9y4cf45";
        };
      };
    };
    "psr/log" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-log-d49695b909c3b7628b6289db5479a1c204601f11";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/log/zipball/d49695b909c3b7628b6289db5479a1c204601f11";
          sha256 = "0sb0mq30dvmzdgsnqvw3xh4fb4bqjncx72kf8n622f94dd48amln";
        };
      };
    };
    "ralouphie/getallheaders" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "ralouphie-getallheaders-120b605dfeb996808c31b6477290a714d356e822";
        src = fetchurl {
          url = "https://api.github.com/repos/ralouphie/getallheaders/zipball/120b605dfeb996808c31b6477290a714d356e822";
          sha256 = "1bv7ndkkankrqlr2b4kw7qp3fl0dxi6bp26bnim6dnlhavd6a0gg";
        };
      };
    };
    "symfony/debug" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-debug-ab42889de57fdfcfcc0759ab102e2fd4ea72dcae";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/debug/zipball/ab42889de57fdfcfcc0759ab102e2fd4ea72dcae";
          sha256 = "0kd3kiy5g0ljx96mvf8hn218mi02z06b1dmk4zcl2jxsppsnkkbw";
        };
      };
    };
    "symfony/polyfill-intl-idn" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-intl-idn-59a8d271f00dd0e4c2e518104cc7963f655a1aa8";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-intl-idn/zipball/59a8d271f00dd0e4c2e518104cc7963f655a1aa8";
          sha256 = "1bcdl48ji0dmswwvw2b66qxdxxawbx8bgicc02la92gacps08n5v";
        };
      };
    };
    "symfony/polyfill-intl-normalizer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-intl-normalizer-219aa369ceff116e673852dce47c3a41794c14bd";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-intl-normalizer/zipball/219aa369ceff116e673852dce47c3a41794c14bd";
          sha256 = "1cwckrazq4p4i9ysjh8wjqw8qfnp0rx48pkwysch6z7vkgcif22w";
        };
      };
    };
    "symfony/polyfill-php72" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-php72-bf44a9fd41feaac72b074de600314a93e2ae78e2";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-php72/zipball/bf44a9fd41feaac72b074de600314a93e2ae78e2";
          sha256 = "11knb688wcf8yvrprgp4z02z3nb6s5xj3wrv77n2qjkc7nc8q7l7";
        };
      };
    };
  };
  devPackages = {
    "fabpot/goutte" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "fabpot-goutte-80a23b64f44d54dd571d114c473d9d7e9ed84ca5";
        src = fetchurl {
          url = "https://api.github.com/repos/FriendsOfPHP/Goutte/zipball/80a23b64f44d54dd571d114c473d9d7e9ed84ca5";
          sha256 = "0xdw8dyzmvvlnd2klac3ax026bibdwd8pzrakws51a2fdl1p8cy1";
        };
      };
    };
    "fzaninotto/faker" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "fzaninotto-faker-848d8125239d7dbf8ab25cb7f054f1a630e68c2e";
        src = fetchurl {
          url = "https://api.github.com/repos/fzaninotto/Faker/zipball/848d8125239d7dbf8ab25cb7f054f1a630e68c2e";
          sha256 = "1nsbmkws5lwfm0nhy67q6awzwcb1qxgnqml6yfy3wfj7s62r6x09";
        };
      };
    };
    "nikic/php-parser" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "nikic-php-parser-34bea19b6e03d8153165d8f30bba4c3be86184c1";
        src = fetchurl {
          url = "https://api.github.com/repos/nikic/PHP-Parser/zipball/34bea19b6e03d8153165d8f30bba4c3be86184c1";
          sha256 = "1yj97j9cdx48566qwjl5q8hkjkrd1xl59aczb1scspxay37l9w72";
        };
      };
    };
    "roave/security-advisories" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "roave-security-advisories-0a2664d739af6996ce1a24a35cb59ed2bbd27f4b";
        src = fetchurl {
          url = "https://api.github.com/repos/Roave/SecurityAdvisories/zipball/0a2664d739af6996ce1a24a35cb59ed2bbd27f4b";
          sha256 = "08njg3nhw60azj6mb95k5b4d8d43va8x02ncx428s8rm0czm06i4";
        };
      };
    };
    "symfony/browser-kit" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-browser-kit-18e73179c6a33d520de1b644941eba108dd811ad";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/browser-kit/zipball/18e73179c6a33d520de1b644941eba108dd811ad";
          sha256 = "04wqnlqf37kjnwmij2rhzjx6760ib9lkqjh2v70kvildzp7an2ca";
        };
      };
    };
    "symfony/css-selector" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-css-selector-b0a190285cd95cb019237851205b8140ef6e368e";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/css-selector/zipball/b0a190285cd95cb019237851205b8140ef6e368e";
          sha256 = "1wpxfb7xcn7sjpcgz45582wxymq9d089a71mz80kmwrlblcvxq99";
        };
      };
    };
    "symfony/deprecation-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-deprecation-contracts-e8b495ea28c1d97b5e0c121748d6f9b53d075c66";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/deprecation-contracts/zipball/e8b495ea28c1d97b5e0c121748d6f9b53d075c66";
          sha256 = "09k869asjb7cd3xh8i5ps824k5y6v510sbpzfalndwy3knig9fig";
        };
      };
    };
    "symfony/dom-crawler" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-dom-crawler-a213cbc80382320b0efdccdcdce232f191fafe3a";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/dom-crawler/zipball/a213cbc80382320b0efdccdcdce232f191fafe3a";
          sha256 = "0cxddqc7193xaa5hx0rlncqi5karxg800a301s1qdqp7ddc3hr86";
        };
      };
    };
    "symfony/polyfill-ctype" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-ctype-6fd1b9a79f6e3cf65f9e679b23af304cd9e010d4";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-ctype/zipball/6fd1b9a79f6e3cf65f9e679b23af304cd9e010d4";
          sha256 = "18235xiqpjx9nzx3pzylm5yzqr6n1j8wnnrzgab1hpbvixfrbqba";
        };
      };
    };
    "symfony/polyfill-mbstring" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-mbstring-9344f9cb97f3b19424af1a21a3b0e75b0a7d8d7e";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-mbstring/zipball/9344f9cb97f3b19424af1a21a3b0e75b0a7d8d7e";
          sha256 = "0y289x91c9lgr8vlixj5blayf9lsgi4nn2gyn3a99brvn2jnh6q8";
        };
      };
    };
    "symfony/polyfill-php80" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-php80-cfa0ae98841b9e461207c13ab093d76b0fa7bace";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-php80/zipball/cfa0ae98841b9e461207c13ab093d76b0fa7bace";
          sha256 = "1kbh4j01kxxc39ls9kzkg7dj13cdlzwy599b96harisysn47jw2n";
        };
      };
    };
    "syspass/extension-installer-plugin" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "syspass-extension-installer-plugin-9805ed94f0eac986c8c35586ca3b682e28a7c465";
        src = fetchurl {
          url = "https://api.github.com/repos/sysPass/composer-plugin-installer/zipball/9805ed94f0eac986c8c35586ca3b682e28a7c465";
          sha256 = "152r5ni5akg5xn1ygg05pmdn4qh5zmwdcks20llxxrhmv7ddciw7";
        };
      };
    };
  };
in
composerEnv.buildPackage {
  inherit src packages devPackages noDev;
  name = "syspass-syspass";
  executable = false;
  symlinkDependencies = false;
  meta = {
    homepage = "https://syspass.org";
    license = "GPL-3.0";
  };
}
