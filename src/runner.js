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

    if (window.navigator && 'serviceWorker' in window.navigator) {
        navigator.serviceWorker.register('sw.js');
    }
    world = new WorldMorph(document.getElementById('world'));
    new IDE_Morph().openIn(world);
    window.requestAnimationFrame(loop);
}

window.onload = startSnap;
