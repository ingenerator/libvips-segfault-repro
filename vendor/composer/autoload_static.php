<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInit6cc295a02fb95c15773ab3a686767153
{
    public static $prefixLengthsPsr4 = array (
        'P' => 
        array (
            'Psr\\Log\\' => 8,
        ),
        'J' => 
        array (
            'Jcupitt\\Vips\\' => 13,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'Psr\\Log\\' => 
        array (
            0 => __DIR__ . '/..' . '/psr/log/src',
        ),
        'Jcupitt\\Vips\\' => 
        array (
            0 => __DIR__ . '/..' . '/jcupitt/vips/src',
        ),
    );

    public static $classMap = array (
        'Composer\\InstalledVersions' => __DIR__ . '/..' . '/composer/InstalledVersions.php',
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInit6cc295a02fb95c15773ab3a686767153::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInit6cc295a02fb95c15773ab3a686767153::$prefixDirsPsr4;
            $loader->classMap = ComposerStaticInit6cc295a02fb95c15773ab3a686767153::$classMap;

        }, null, ClassLoader::class);
    }
}