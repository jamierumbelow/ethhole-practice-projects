import React, { useState, useEffect, useMemo } from "react";
import { Contract } from "@ethersproject/contracts";
import { getDefaultProvider } from "@ethersproject/providers";

import { Body, Button, Header } from "./components";
import useWeb3Modal from "./hooks/useWeb3Modal";

import { addresses, abis } from "@project/contracts";

const useContract = () => {
  const defaultProvider = getDefaultProvider("http://localhost:7545");
  return useMemo(
    () => new Contract(addresses.voting, abis.voting, defaultProvider),
    [defaultProvider]
  );
};

const useWeb3Call = (getter, deps, defaultVal = []) => {
  const [thing, setThing] = useState(defaultVal);
  const v = useContract();

  useEffect(() => {
    (async () => setThing(await getter(v)))();
  }, [getter, v, ...deps]);

  return [thing];
};

function WalletButton({ provider, loadWeb3Modal, logoutOfWeb3Modal }) {
  return (
    <Button
      onClick={() => {
        if (!provider) {
          loadWeb3Modal();
        } else {
          logoutOfWeb3Modal();
        }
      }}
    >
      {!provider ? "Connect Wallet" : "Disconnect Wallet"}
    </Button>
  );
}

function App() {
  const [provider, loadWeb3Modal, logoutOfWeb3Modal] = useWeb3Modal();

  const [elections] = useWeb3Call(
    async (v) => {
      const len = (await v.getAllElectionsLength()).toNumber();
      const elections = [];

      for (let index = 0; index < len; index++) {
        elections.push(await v.elections(index));
      }

      return elections;
    },
    [],
    []
  );

  return (
    <div>
      <Header>
        <WalletButton
          provider={provider}
          loadWeb3Modal={loadWeb3Modal}
          logoutOfWeb3Modal={logoutOfWeb3Modal}
        />
      </Header>
      <Body>
        {elections.map((election) => {
          console.log(election);
        })}
      </Body>
    </div>
  );
}

export default App;
