/* eslint-disable react/jsx-props-no-spreading */
import { formatEther, parseEther } from "@ethersproject/units";
import React, { useCallback, useEffect, useState } from "react";
import { useContractLoader, useContractReader } from "../hooks";

const useControlledInput = (defaultValue = "") => {
  const [value, setValue] = useState(defaultValue);
  const onChange = useCallback(({ target: { value } }) => setValue(value), []);

  return { value, onChange };
};

const Form = ({ contracts, currentPrice, onSubmit: parentSubmit }) => {
  const ctaUrl = useControlledInput();
  const imageUrl = useControlledInput();
  const text = useControlledInput();
  const price = useControlledInput(currentPrice);

  useEffect(() => price.onChange({ target: { value: currentPrice + 1 } }), [currentPrice]);

  const onSubmit = useCallback(
    e => {
      e.preventDefault();
      parentSubmit({ ctaUrl: ctaUrl.value, imageUrl: imageUrl.value, text: text.value, price: price.value });
    },
    [ctaUrl, imageUrl, text, price],
  );

  return (
    <form onSubmit={onSubmit}>
      <p>
        <label>Link URL:</label>
        <span>
          <input type="url" {...ctaUrl} />
        </span>
      </p>
      <p>
        <label>Image URL:</label>
        <span>
          <input type="url" {...imageUrl} />
        </span>
      </p>
      <p>
        <label>Text:</label>
        <span>
          <input type="text" {...text} />
        </span>
      </p>
      <p>
        <label>Price:</label>
        <span>
          <input type="number" {...price} min={currentPrice + 1 || 0} />
        </span>
      </p>
      <p>
        <button type="submit">Buy</button>
      </p>
    </form>
  );
};

const Buy = ({ provider, tx, onClose }) => {
  const contracts = useContractLoader(provider);
  const currentPrice = useContractReader(contracts, "Ads", "currentPrice");

  const onSubmit = useCallback(
    async ({ ctaUrl, imageUrl, text, price }) => {
      console.log(contracts.Ads);
      await tx(contracts.Ads.buy(ctaUrl, imageUrl, text, { value: parseEther(price) }));
      onClose();
    },
    [tx, contracts],
  );

  return <Form contracts={contracts} currentPrice={currentPrice ? formatEther(currentPrice) : 0} onSubmit={onSubmit} />;
};

export default Buy;
