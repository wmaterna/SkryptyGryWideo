export const getProducts = async () => {
    const path = '/products';
    const response = await fetch(path);
    if (response.ok) {
        return await response.json();
    } else {
        throw new Error('Unable to get Products');
    }
}