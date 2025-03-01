import React, { ReactNode } from "react";
import "./styles.css";
import { BrowserRouter, Route, Routes } from 'react-router-dom';

import { TravelSearch } from './pages';

const handleSearch = (city, type) => {
  const apiUrl = "/api/search";
  const searchParams = new URLSearchParams({
    city: city,
    type: type,
  }).toString();
  window.location.href = `${apiUrl}?${searchParams}`;
};

export default function App() {
  return (
      <BrowserRouter>
        <Routes>
            <Route path="/" element={<TravelSearch />} />
        </Routes>
      </BrowserRouter>
  );
}
