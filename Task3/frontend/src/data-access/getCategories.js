export const getCategories = async () => {
    const path = '/categories';
    const response = await fetch(path);
    if (response.ok) {
        return await response.json();
    } else {
        throw new Error('Unable to get Categories');
    }
}