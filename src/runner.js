var world;

function startSnap() {
    var FPS = 67,
        lastTime = 0,
        loop;

    loop = function(timestamp) {
        window.requestAnimationFrame(loop);
        if (timestamp - lastTime < 1000 / FPS) {
            return;
        }
        world.doOneCycle();
        lastTime = Math.max(
            lastTime + 1000 / FPS,
            timestamp - 1000 / FPS
        );
    };

    if ('serviceWorker' in navigator) {
        navigator.serviceWorker.register('sw.js');
    }
    world = new WorldMorph(document.getElementById('world'));
    new IDE_Morph().openIn(world);
    window.requestAnimationFrame(loop);
}

window.onload = function () {
    if (window.location.href.substr(0, 5) !== 'https') {
        var url = 'https' + window.location.href.substr(4);

        fetch(url).then(function (response) {
            window.location.href = url;
        }).catch(function (error) {
            startSnap();
        });
    } else {
        startSnap();
    }
};

