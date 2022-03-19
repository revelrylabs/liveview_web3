const web3 = new ethers.providers.Web3Provider(window.ethereum)


function init() {

    // Check that the web page is run in a secure context,
    // as otherwise MetaMask won't be available
    if (location.protocol !== 'https:') {
        console.log("FAILING AT HTTPS")
        this.pushEvent("https-check-failed", {https: false})
    }
}


export const Metamask = {
    mounted() {
        window.addEventListener('load', async () => {
            init();

            web3.listAccounts().then((accounts) => {
                this.pushEvent("account-check", {connected: accounts.length > 0})
            })
        })

        window.addEventListener(`phx:connect-metamask`, (e) => {
            web3.provider.request({method: 'eth_requestAccounts'}).then((accounts) => {
                if (accounts.length > 0) {
                const signer = web3.getSigner();
                signer.signMessage('Signing this message is verification that the Metamask wallet you are using belongs to you.').then((signature) => {

                    console.log("SIGNATURE:::::: ", signature)
                    signer.getAddress().then((address) => {
                        console.log("ADDRESS::::: ", address)
                        this.pushEvent("wallet-connected", {public_address: address, signature: signature})
                    });

                })
                }
            }, (error) => console.log(error))

        })

    },
}

