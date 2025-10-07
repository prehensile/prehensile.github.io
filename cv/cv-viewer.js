function initFrame(){
    try {

        const iframe = document.getElementById('cv-content');
        const iframeDoc = iframe.contentDocument;

        // Inject CSS to increase font size
        const style = iframeDoc.createElement('style');
        style.textContent = `
            .markdown-body {
                font-size: 12pt !important;
            }
        `;
        iframeDoc.head.appendChild(style);

        // Make all links target _top
        const linkTarget = "_top";
        const links = iframeDoc.querySelectorAll('a');
        links.forEach(link => {
            link.setAttribute('target', linkTarget);
        });

        // Add PDF link to first bullet list
        const firstList = iframeDoc.querySelector('ul');
        if (firstList) {
            const li = iframeDoc.createElement('li');
            li.textContent = "Download this CV as a "
            const a = iframeDoc.createElement('a');
            a.href = 'cv.pdf';
            a.target = linkTarget;
            a.textContent = 'PDF document';
            li.appendChild(a);
            firstList.appendChild(li);
        }

        // Set iframe height to match content
        const height = iframeDoc.documentElement.scrollHeight;
        iframe.style.height = height + 'px';

        // Disable scrolling
        iframe.setAttribute('scrolling', 'no');

    } catch (e) {
        console.error('Could not access iframe content:', e);
    }
}

function windowLoader( w, callback ){
    if (w.document.readyState === 'complete') {
        callback();
    } else {
        w.onload = function() {
            callback();
        };
    }
}

function initDocument(){
    const iframe = document.getElementById('cv-content');
    windowLoader(
        iframe.contentWindow,
        function(){
            initFrame();
        }
    )
}

windowLoader(
    window,
    function(){
        initDocument();
    }
)

